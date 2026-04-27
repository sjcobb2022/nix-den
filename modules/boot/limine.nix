{
  den.aspects.limine = {
    nixos = {pkgs, ...}: {
      boot.loader.limine = {
        enable = true;
        efiSupport = true;
        secureBoot.enable = true;
      };
      boot.loader.efi.canTouchEfiVariables = true;

      environment.systemPackages = [pkgs.sbctl];
    };
  };
}
