{den, ...}: {
  den.aspects.sjcobb = {
    includes = [
      den.provides.primary-user
      (den.provides.user-shell "fish")
      den.aspects.impermanence-home
      den.aspects.nvf
      den.aspects.gpg
      den.aspects.fish
      den.aspects.starship
      den.aspects.git
      den.aspects.kit
    ];

    nixos = {...}: {
      users.users.sjcobb = {
        isNormalUser = true;
        group = "sjcobb";
        extraGroups = [
          "wheel"
          "video"
          "audio"
          "networkmanager"
        ];
      };
      users.groups.sjcobb = {};
    };

    homeManager = {...}: {
      programs.git.settings.user = {
        name = "sjcobb2022";
        email = "sjcobb2003@gmail.com";
      };
    };
  };
}
