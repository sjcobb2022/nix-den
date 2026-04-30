{
  den,
  inputs,
  ...
}: {
  flake-file.inputs.impermanence = {
    url = "github:nix-community/impermanence";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  den.aspects.impermanence = {
    nixos = {
      imports = [inputs.impermanence.nixosModules.impermanence];
    };

    impermanence = {
      hideMounts = true;
      directories = [
        "/etc/NetworkManager/system-connections"
        "/var/lib/sbctl"
        "/var/lib/bluetooth"
        "/var/lib/systemd/coredump"
        "/var/lib/nixos"
        "/var/log"
      ];
      files = [
        "/etc/machine-id"
      ];
    };

    impermanenceHome = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
      ];
      files = [
        ".screenrc"
      ];
    };
  };
}
