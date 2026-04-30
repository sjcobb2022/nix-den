{den, ...}: {
  den.aspects.mactop = {
    includes = [
      den.provides.hostname
      den.aspects.stylix
    ];

    darwin = {
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
        taps = [];
        brews = ["libiconv"];
        casks = ["redisinsight" "dbeaver-community" "openvpn-connect" "yubico-yubikey-manager" "postman"];
      };
    };
  };
}
