{
  den,
  inputs,
  ...
}: {
  den.aspects.stylix = {
    nixos = {pkgs, ...}: {
      imports = [inputs.stylix.nixosModules.stylix];

      stylix = {
        enable = true;
        autoEnable = true;
        enableReleaseChecks = false;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
        polarity = "dark";

        fonts = {
          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono Nerd Font";
          };
          sansSerif = {
            package = pkgs.inter;
            name = "Inter";
          };
          serif = {
            package = pkgs.noto-fonts;
            name = "Noto Serif";
          };
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
        };
      };

      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        noto-fonts-cjk-sans
      ];
    };

    homeManager = {...}: {
      stylix.enableReleaseChecks = false;
    };
  };
}
