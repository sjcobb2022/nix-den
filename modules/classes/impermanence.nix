{
  lib,
  den,
  ...
}: let
  impermanenceAdapter = {
    options = {
      directories = lib.mkOption {
        type = lib.types.listOf lib.types.anything;
        default = [];
      };
      files = lib.mkOption {
        type = lib.types.listOf lib.types.anything;
        default = [];
      };
      hideMounts = lib.mkOption {
        type = lib.types.anything;
        default = false;
      };
      users = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule {
          options = {
            directories = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [];
            };
            files = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [];
            };
          };
        });
        default = {};
      };
    };
  };

  impermanenceHostClass = path: {
    class,
    aspect-chain,
  }:
    den.batteries.forward {
      each = lib.singleton true;
      fromClass = _: "impermanence";
      intoClass = _: "nixos";
      intoPath = _: ["environment" "persistence" path];
      fromAspect = _: lib.head aspect-chain;
      guard = {options, ...}: options ? environment && options.environment ? persistence;
      adapterModule = impermanenceAdapter;
    };
in {
  den.provides.impermanence = path: (impermanenceHostClass path);
}
