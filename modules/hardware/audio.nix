{
  den.aspects.audio = {
    nixos = {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };

    homeManager = {pkgs, ...}: {
      services.mpris-proxy.enable = true;
      home.packages = [
        pkgs.pavucontrol
        pkgs.playerctl
      ];
    };
  };
}
