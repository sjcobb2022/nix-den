{den, ...}: {
  den.aspects.fish = {
    nixos = {...}: {
      programs.fish.enable = true;
    };

    homeManager = {...}: {
      programs.fish = {
        enable = true;
        # fish_greeting = "";
        interactiveShellInit = ''
          set fish_greeting
          fish_vi_key_bindings
        '';
        shellAbbrs = {
          jqless = "jq -C | less -r";

          g = "git";
          ga = "git add";
          gc = "git commit";
          gp = "git push";
          gst = "git status";

          gcl = "git clone";

          n = "nix";
          nd = "nix develop -c $SHELL";
          ns = "nix shell";
          nsn = "nix shell nixpkgs#";
          nb = "nix build";
          nbn = "nix build nixpkgs#";
          nf = "nix flake";

          # ls = mkIf hasEza "eza";
          #
          # cd = mkIf hasZoxide "z";
        };
        # shellAliases = {
        #   # Clear screen and scrollback
        #   clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
        # };
      };
    };

    # Persistence for fish history and data
    provides.impermanence-home.nixos = {user, ...}: {
      home-manager.users.${user.name}.home.persistence."/persist".directories = [
        ".local/share/fish"
      ];
    };
  };
}
