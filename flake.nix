{
  description = "reusable home manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    idris-pkgs = {
      url = "github:idrisr/idris-pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];

      stdenvSystemAlias = final: prev: {
        stdenv = prev.stdenv // {
          system = prev.stdenv.hostPlatform.system;
        };
        system = prev.stdenv.hostPlatform.system;
      };

      baseOverlays = [
        stdenvSystemAlias
        inputs.idris-pkgs.overlays.default
        (import ./modules/kdenlive)
      ];

      overlays = {
        default = nixpkgs.lib.composeManyExtensions (
          baseOverlays
        );
      };

      pkgsFor = system: import nixpkgs {
        inherit system;
        overlays = baseOverlays;
        config.allowUnfree = true;
      };

      mkHome = { system, graphical }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor system;
          modules = [
            ./home.nix
          ];

          extraSpecialArgs = {
            inherit inputs;
            inherit graphical;
            pkgs = pkgsFor system;
          };
        };

      homeConfigEntries = system: {
        "graphical-${system}" = mkHome {
          inherit system;
          graphical = true;
        };
        "headless-${system}" = mkHome {
          inherit system;
          graphical = false;
        };
      };

      homeConfigurationsBySystem = builtins.foldl'
        (acc: system: acc // homeConfigEntries system)
        { }
        systems;

    in
    {
      inherit overlays;

      homeConfigurations = homeConfigurationsBySystem;

      packages = nixpkgs.lib.genAttrs systems (system: {
        headless = homeConfigurationsBySystem."headless-${system}".activationPackage;
        graphical = homeConfigurationsBySystem."graphical-${system}".activationPackage;
      });

      checks = nixpkgs.lib.genAttrs systems (system: {
        home-graphical =
          homeConfigurationsBySystem."graphical-${system}".activationPackage;
        home-headless =
          homeConfigurationsBySystem."headless-${system}".activationPackage;
      });

      nixosModules.graphical = let graphical = true; in {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          users.hippoid = import ./home.nix {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            inherit inputs;
            inherit graphical;
          };

          extraSpecialArgs = {
            inherit inputs;
            inherit graphical;
          };
        };
      };
    };
}
