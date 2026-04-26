{
  den,
  inputs,
  lib,
  ...
}: {
  flake-file.inputs.nixos-hardware.url = "github:NixOS/nixos-hardware";

  den.ctx.user.includes = [(den.provides.impermanenceHome "/persist")];
  den.ctx.host.includes = [(den.provides.impermanence "/persist")];

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

      # set all users on this laptop to not be mutable.
      users.users.mutableUsers = false;

      hardware.facter.reportPath = ./facter.json;

      # Override until https://github.com/NixOS/nixpkgs/issues/485579#issuecomment-4157687281 fixed
      hardware.facter.detected.boot.graphics.kernelModules = lib.mkForce ["amdgpu"];

      # Laptop-specific
      services.fwupd.enable = true;
      services.logind.settings.Login.HandleLidSwitch = "suspend";
    };
  };
}
