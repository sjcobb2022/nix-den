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
  };
}
