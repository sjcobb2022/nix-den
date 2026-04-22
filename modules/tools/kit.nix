{den, ...}: {
  den.aspects.kit = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        fd
        ripgrep
        bottom
        jq
      ];

      programs.bat.enable = true;
      programs.eza.enable = true;
      programs.zoxide.enable = true;
    };

    # Fish aliases for eza/zoxide - include via den.aspects.kit._.fish-aliases
    provides.fish-aliases.homeManager = {...}: {
      programs.fish.shellAbbrs = {
        ls = "eza";
        ll = "eza -l";
        la = "eza -la";
        lt = "eza --tree";
        cd = "z";
      };
    };
  };
}
