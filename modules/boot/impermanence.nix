{
  den,
  inputs,
  ...
}: {
  den.aspects.impermanence = {
    nixos = {...}: {
      imports = [inputs.impermanence.nixosModules.impermanence];

      programs.fuse.userAllowOther = true;

      # hideMounts is set here since it's not part of directories/files
      environment.persistence."/persist".hideMounts = true;

      # SSH host keys in /persist (overrides mkDefault in ssh.nix)
      services.openssh.hostKeys = [
        {
          path = "/persist/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];

      # sops-nix needs keys from /persist (accessible before bind mounts)
      sops.age.sshKeyPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];
    };

    # Parametric impermanence class - only applies in host context
    impermanence = {host, ...}: {
      directories = [
        "/etc/NetworkManager/system-connections"
        "/var/lib/sbctl"
        "/var/lib/bluetooth"
        "/var/lib/systemd/coredump"
        "/var/lib/nixos"
        "/var/log"
        "/srv"
      ];
      files = [
        "/etc/machine-id"
      ];
    };
  };
}
