{
  den,
  inputs,
  ...
}: {
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.sops-base = {
    nixos = {config, ...}: {
      imports = [inputs.sops-nix.nixosModules.sops];

      sops = {
        defaultSopsFile = ../../secrets/${config.networking.hostName}.yaml;
      };
    };
  };

  den.aspects.sops-default-ssh = {
    nixos = {
      sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };
  };

  den.aspects.sops-impermanence = {
    nixos = {
      sops.age.sshKeyPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];
    };
  };

  den.aspects.sops = {
    includes = [
      den.aspects.sops-base
      # Only include default SSH keys when impermanence is NOT present
      (
        den.lib.aspects.fx.includes.includeIf
        (ctx: !ctx.hasAspect den.aspects.impermanence)
        [den.aspects.sops-default-ssh]
      )
      # Only include impermanence keys when impermanence IS present
      (
        den.lib.aspects.fx.includes.includeIf
        (ctx: ctx.hasAspect den.aspects.impermanence)
        [den.aspects.sops-impermanence]
      )
    ];
  };
}
