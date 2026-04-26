{
  lib,
  den,
  inputs,
  ...
}: {
  den.default.nixos.system.stateVersion = "25.11";
  den.default.homeManager.home.stateVersion = "25.11";

  den.default.nixos.nix = {
    settings = {
      trusted-users = ["root" "@wheel"];
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      system-features = ["big-parallel" "nixos-test" "kvm"];
    };
    # Add each flake input as a registry for nix3 commands
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    # Add nixpkgs to NIX_PATH for nix2 commands
    nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
  };

  den.fxPipeline = true;

  den.default.nixos.programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  # Global shell integration settings
  den.default.homeManager.home.shell = {
    enableFishIntegration = true;
    enableNushellIntegration = false;
    enableZshIntegration = false;
    enableIonIntegration = false;
  };

  # enable hm by default
  den.schema.user.classes = lib.mkDefault ["homeManager" "impermanenceHome"];

  # host<->user provides
  den.ctx.user.includes = [den._.mutual-provider];

  # Overlay for pkgs.unstable
  den.default.nixos.nixpkgs.overlays = [
    (final: _prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (final) system;
        config.allowUnfree = true;
      };
    })
  ];

  # Default formatter
  perSystem = {pkgs, ...}: {
    formatter = pkgs.alejandra;
  };
}
