{
  den.aspects.networking = {
    nixos = {
      networking = {
        networkmanager.enable = true;
        networkmanager.dns = "systemd-resolved";

        nameservers = ["1.1.1.1" "1.0.0.1"];

        firewall = {
          enable = true;
          checkReversePath = false;
        };
      };

      services.resolved = {
        enable = true;
        fallbackDns = ["1.1.1.1" "1.0.0.1"];
      };

      programs.captive-browser = {
        interface = "wlo1";
        enable = true;
      };
    };

    darwin = {
      networking = {
        knownNetworkServices = ["Thunderbolt Bridge" "Wi-Fi"];
        dns = ["1.1.1.1" "1.0.0.1"];
      };
    };
  };
}
