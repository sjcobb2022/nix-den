{den, ...}: {
  den.aspects.power = {
    nixos = {...}: {
      services.tlp.enable = true;
      services.upower.enable = true;
    };
  };
}
