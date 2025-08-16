{
  description = "reusable home manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    idris-pkgs = {
      # url = "github:idrisr/idris-pkgs";
      url = "/home/hippoid/fun/idris-pkgs/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rofi = {
      url = "github:idrisr/rofi-picker/haskell";
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
    zettel = {
      url = "github:idrisr/zettel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      makeHomeModules = { pkgs, inputs, graphical }:
        [
          (import ./home.nix { inherit pkgs inputs graphical; })
        ];

      modules = makeHomeModules {
        inherit pkgs inputs;
        graphical = true;
      };

      overlays = [
        inputs.idris-pkgs.overlays.default
        (import ./modules/qrcp "6969")
        (import ./modules/xournal)
        (import ./modules/tikzit)
        (import ./modules/kdenlive)
        # (import ./modules/brave)
        inputs.rofi.overlays.all
        inputs.zettel.overlays.zettel
      ];

      pkgs = import nixpkgs {
        inherit system;
        inherit overlays;
        config.allowUnfree = true;
      };

    in
    rec
    {
      # used by nixos configuration when importing this stand-alone hm config
      inherit overlays;

      homeConfigurations = {
        "graphical" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            (import ./home.nix {
              inherit pkgs inputs;
              graphical = true;
            })
          ];

          extraSpecialArgs = {
            inherit inputs;
            graphical = true;
          };
        };

        "headless" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            (import ./home.nix {
              inherit pkgs inputs;
              graphical = true;
            })
          ];

          extraSpecialArgs = {
            inherit inputs;
            graphical = false;
          };
        };
      };

      packages.${system} = {
        headless = homeConfigurations.headless.activationPackage;
        graphical = homeConfigurations.graphical.activationPackage;
      };

      homeManagerModules.base = {
        imports = modules;
      };

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
