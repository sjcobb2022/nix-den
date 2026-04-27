{
  den.aspects.nvidia = {
    nixos = {
      config,
      pkgs,
      ...
    }: {
      powerManagement.enable = true;

      hardware.nvidia = {
        modesetting.enable = true;

        # Nvidia power management
        powerManagement.enable = true;
        # Fine-grained power management (Turing or newer)
        powerManagement.finegrained = true;

        # Dynamic Boost (nvidia-powerd daemon)
        dynamicBoost.enable = false;

        # Open source kernel module (Turing+, driver 515.43.04+)
        open = false;

        # Nvidia settings menu
        nvidiaSettings = false;

        # Driver version
        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
        ];
        extraPackages32 = with pkgs; [
          libvdpau-va-gl
          libva-vdpau-driver
        ];
      };
    };
  };
}
