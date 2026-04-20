{den, ...}: {
  den.aspects.mactop = {
    includes = [
      den.provides.hostname
      den.aspects.stylix
    ];

    darwin = {...}: {
      services.nix-daemon.enable = true;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      system.defaults = {
        dock.autohide = true;
        finder.AppleShowAllExtensions = true;
      };

      homebrew = {
        enable = true;
        onActivation.cleanup = "uninstall";
      };
    };
  };
}
