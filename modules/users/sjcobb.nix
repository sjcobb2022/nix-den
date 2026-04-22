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
      den.aspects.kit.provides.fish-aliases
    ];

    # User class - forwards to users.users.sjcobb
    # primary-user already provides wheel and networkmanager
    user = {config, ...}: {
      group = "sjcobb";
      extraGroups = ["video" "audio"];
      hashedPasswordFile = config.sops.secrets.sjcobb-pass.path;
    };

    # Group definition and mutableUsers setting
    nixos = {...}: {
      users.groups.sjcobb = {};
      users.mutableUsers = false;
    };

    homeManager = {...}: {
      programs.git.settings.user = {
        name = "sjcobb2022";
        email = "sjcobb2003@gmail.com";
      };
    };
  };
}
