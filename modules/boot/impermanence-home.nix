{den, ...}: {
  den.aspects.impermanence-home = {
    homeManager = {...}: {
      # NixOS module auto-imports home-manager impermanence module
      home.persistence."/persist" = {
        directories = [
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Videos"
          "Projects"
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".ssh";
            mode = "0700";
          }
          {
            directory = ".local/share/keyrings";
            mode = "0700";
          }
          {
            directory = ".config/sops/age";
            mode = "0700";
          }
        ];
      };
    };
  };
}
