{den, ...}: {
  den.aspects.git = {
    homeManager = {...}: {
      programs.git = {
        enable = true;
        ignores = [
          ".direnv"
          "result"
          ".envrc"
        ];
        settings = {
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
          pull.rebase = true;
        };
      };

      programs.delta.enable = true;

      programs.gh = {
        enable = true;
        settings.git_protocol = "https";
      };
    };

    # Persistence for gh auth and config
    provides.impermanence-home.nixos = {user, ...}: {
      home-manager.users.${user.name}.home.persistence."/persist".directories = [
        ".config/gh"
      ];
    };
  };
}
