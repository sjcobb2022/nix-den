{
  den,
  inputs,
  ...
}: {
  den.aspects.sops = {
    nixos = {
      config,
      lib,
      ...
    }: {
      imports = [inputs.sops-nix.nixosModules.sops];

      sops = {
        defaultSopsFile = ../../secrets/${config.networking.hostName}.yaml;
        # Default path (overridden by impermanence aspect when included)
        age.sshKeyPaths = lib.mkDefault ["/etc/ssh/ssh_host_ed25519_key"];
      };
    };
  };
}
