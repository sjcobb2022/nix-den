{den, ...}: {
  den.aspects.ssh = {host, ...}: {
    nixos = {lib, ...}: {
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
          StreamLocalBindUnlink = "yes";
          GatewayPorts = "clientspecified";
        };

        # Default host keys (overridden by impermanence aspect)
        hostKeys =
          if host.hasAspect den.aspects.impermanence
          then [
            {
              path = "/persist/etc/ssh/ssh_host_ed25519_key";
              type = "ed25519";
            }
          ]
          else [
            {
              path = "/persist/etc/ssh/ssh_host_ed25519_key";
              type = "ed25519";
            }
          ];
      };

      # Passwordless sudo when SSH'd with keys
      security.pam.sshAgentAuth.enable = true;
    };

    homeManager = {
      programs.ssh = {
        enable = true;
        addKeysToAgent = "yes";

        # GPG agent forwarding for all hosts
        matchBlocks."*" = {
          remoteForwards = [
            {
              bind.address = "/run/user/%U/gnupg/S.gpg-agent";
              host.address = "/run/user/%U/gnupg/S.gpg-agent.extra";
            }
          ];
        };
      };
    };
  };
}
