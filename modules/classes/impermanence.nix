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
    };
  };

  impermanenceHostClass = path: {
    class,
    aspect-chain,
  }:
    den.provides.forward {
      each = lib.singleton true;
      fromClass = _: "impermanence";
      intoClass = _: "nixos";
      intoPath = _: ["environment" "persistence" path];
      fromAspect = _: lib.head aspect-chain;
      guard = {options, ...}: options ? environment && options.environment ? persistence;
      adapterModule = impermanenceAdapter;
    };

  impermanenceUserClass = path: {
    host,
    user,
  }: {
    class,
    aspect-chain,
  }:
    den.provides.forward {
      each = lib.singleton user;
      fromClass = _: "impermanenceHome";
      intoClass = _: "homeManager";
      intoPath = _: ["home" "persistence" path];
      fromAspect = _: lib.head aspect-chain;
      adapterModule = impermanenceAdapter;
    };
in {
  den.provides.impermanence = path: (impermanenceHostClass path);
  den.provides.impermanenceHome = path: (impermanenceUserClass path);
}
