{den, ...}: {
  den.aspects.sjcobb = {
    includes = [
      den._.host-aspects
      den.provides.primary-user
      (den.provides.user-shell "fish")
      den.aspects.nvf
      den.aspects.gpg
      den.aspects.fish
      den.aspects.starship
      den.aspects.git
      den.aspects.kit
    ];

    # User class - forwards to users.users.sjcobb
    user = {config, ...}: {
      group = "sjcobb";
      extraGroups = ["video" "audio"];
      hashedPasswordFile = config.sops.secrets.sjcobb-pass.path;
    };

    nixos = {
      sops.secrets.sjcobb-pass = {
        format = "yaml";
        sopsFile = ../../secrets/common.yaml;
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
