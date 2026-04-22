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

      sops.secrets.sjcobb-pass = {
        format = "yaml";
        # can be also set per secret
        sopsFile = ../../secrets/common.yaml;
      };

      sops = {
        defaultSopsFile = ../../secrets/${config.networking.hostName}.yaml;
        # Default path (overridden by impermanence aspect when included)
        age.sshKeyPaths = lib.mkDefault ["/etc/ssh/ssh_host_ed25519_key"];
      };
    };
  };
}
