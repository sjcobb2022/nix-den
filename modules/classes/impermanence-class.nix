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

  impermanenceUserClass = path: {user, ...}:
    den.provides.forward {
      each = lib.singleton user;
      fromClass = _: "impermanence";
      intoClass = _: "homeManager";
      intoPath = _: ["home" "persistence" path];
      fromAspect = u: den.aspects.${u.aspect};
      guard = {options, ...}: options ? home && options.home ? persistence;
      adapterModule = impermanenceAdapter;
    };

  impermanenceHostClass = path: {host, ...}:
    den.provides.forward {
      each = lib.singleton host;
      fromClass = _: "impermanence";
      intoClass = _: host.class;
      intoPath = _: ["environment" "persistence" path];
      fromAspect = h: den.aspects.${h.aspect};
      guard = {options, ...}: options ? environment && options.environment ? persistence;
      adapterModule = impermanenceAdapter;
    };
in {
  den.provides.impermanence-user = path: (impermanenceUserClass path);
  den.provides.impermanence-host = path: (impermanenceHostClass path);
}
