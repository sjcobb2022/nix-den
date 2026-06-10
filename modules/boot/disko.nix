{
  den,
  inputs,
  ...
}: {
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Parametric provider - takes device path as argument
  den.provides.disko-luks-btrfs = device: {
    nixos = {
      host,
      lib,
      utils,
      ...
    }: {
      imports = [inputs.disko.nixosModules.disko];

      # Wipe root subvolume on boot, keeping old snapshots for 30 days
      boot.initrd.systemd = {
        enable = true; # Default in 26.05
        services.wipe-file-systems = {
          # Specify dependencies explicitly
          unitConfig.DefaultDependencies = false;
          # The script needs to run to completion before this service is done
          serviceConfig.Type = "oneshot";
          # This service is required for boot to succeed
          requiredBy = ["initrd.target"];
          # Should complete before any file systems are mounted
          before = ["sysroot.mount"];

          # Wait for the unlocked LUKS device to appear
          requires = ["${utils.escapeSystemdPath "/dev/mapper/crypted"}.device"];
          after = [
            "${utils.escapeSystemdPath "/dev/mapper/crypted"}.device"
            # Allow hibernation to resume before trying to alter any data
            "local-fs-pre.target"
          ];

          script = ''
            mkdir /btrfs_tmp
            mount /dev/mapper/crypted /btrfs_tmp
            if [[ -e /btrfs_tmp/root ]]; then
                mkdir -p /btrfs_tmp/old_roots
                timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%d_%H:%M:%S")
                mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
            fi

            for i in $(find /btrfs_tmp/old_roots/ -mindepth 1 -maxdepth 1 -mtime +30); do
                btrfs subvolume delete --recursive "$i"
            done

            btrfs subvolume create /btrfs_tmp/root
            umount /btrfs_tmp
          '';
        };
      };

      disko.devices.disk.main = {
        inherit device;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/persist" =
                      lib.mkIf (host.hasAspect den.aspects.impermanence)
                      {
                        mountpoint = "/persist";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "1G";
                    };
                  };
                };
              };
            };
          };
        };
      };

      fileSystems."/persist" =
        lib.mkIf (host.hasAspect den.aspects.impermanence)
        {
          neededForBoot = true;
        };
    };
  };
}
