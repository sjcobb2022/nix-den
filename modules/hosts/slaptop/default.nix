{
  den,
  inputs,
  lib,
  ...
}: {
  den.aspects.slaptop = {
    includes = [
      den.provides.hostname
      (den.provides.disko-luks-btrfs "/dev/nvme0n1")
      den.aspects.impermanence
      den.aspects.limine
      den.aspects.sops
      den.aspects.ssh
      den.aspects.yubikey
      den.aspects.bluetooth
      den.aspects.audio
      den.aspects.networking
      den.aspects.power
      den.aspects.stylix
      den.aspects.nvidia
    ];

    nixos = {pkgs, ...}: {
      imports = [
        inputs.nixos-hardware.nixosModules.omen-15-en1007sa
      ];

      hardware.facter.reportPath = ./facter.json;
      hardware.facter.detected.boot.graphics.kernelModules = lib.mkForce ["amdgpu"];

      # Laptop-specific
      services.fwupd.enable = true;

      environment.systemPackages = with pkgs; [nh];
    };
  };
}
