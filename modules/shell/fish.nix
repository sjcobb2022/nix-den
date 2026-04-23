{den, ...}: {
  den.aspects.fish = {
    nixos = {...}: {
      programs.fish.enable = true;
    };

    homeManager = {...}: {
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          fish_vi_key_bindings
        '';
        functions = {
          fish_greeting = "";
        };
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
        };
        shellAliases = {
          # Clear screen and scrollback
          clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
        };
      };
    };

    # In the user context
    impermanence = {user, ...}: {
      directories = [".local/share/fish"];
    };
  };
}
