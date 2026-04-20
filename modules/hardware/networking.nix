{den, ...}: {
  den.aspects.networking = {
    nixos = {...}: {
      networking.networkmanager = {
        enable = true;
        dns = "systemd-resolved";
      };
      services.resolved.enable = true;
      networking.firewall.enable = true;
    };
  };
}
