{den, ...}: {
  den.aspects.networking = {
    nixos = {...}: {
      networking.networkmanager = {
        enable = true;
        dns = "systemd-resolved";
      };
      networking.nameservers = ["1.1.1.1" "1.0.0.1"];

      services.resolved = {
        enable = true;
        fallbackDns = ["1.1.1.1" "1.0.0.1"];
      };

      networking.firewall = {
        enable = true;
        checkReversePath = false;
      };

      programs.captive-browser = {
        interface = "wlo1";
        enable = true;
      };
    };

    darwin = {...}: {
      networking = {
        knownNetworkServices = ["Thunderbolt Bridge" "Wi-Fi"];
        dns = ["1.1.1.1" "1.0.0.1"];
      };
    };
  };
}
