{
  description = "reusable home manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    urlq = {
      url = "git+file:../fun/video-downloader";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprvoice = {
      url = "git+file:../fun/hyprvoice";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
        (self: super: {
          latexindent = super.writeShellScriptBin "latexindent" ''
            exec ${super.texlivePackages.latexindent}/bin/latexindent --modifylinebreaks "$@"
          '';
        })
        inputs.idris-pkgs.overlays.default
      ];

      linuxOverlays = [
        (import ./modules/qrcp "6969")
        (import ./modules/kdenlive)
        inputs.urlq.overlays.default
        inputs.rofi.overlays.all
        inputs.zettel.overlays.zettel
        inputs.hyprvoice.overlays.default
      ];

      overlayListFor = system:
        baseOverlays
        ++ nixpkgs.lib.optionals (nixpkgs.lib.strings.hasSuffix "linux" system) linuxOverlays
        ++ [
          (self: super: {
            latexindent = super.writeShellScriptBin "latexindent" ''
              exec ${super.latexindent}/bin/latexindent -m "$@"
            '';
          })
        ];

      overlays = {
        default = nixpkgs.lib.composeManyExtensions (
          baseOverlays
          ++ map (overlay: final: prev: if prev.stdenv.isLinux then overlay final prev else { })
            linuxOverlays
          ++ [
            (self: super: {
              latexindent = super.writeShellScriptBin "latexindent" ''
                exec ${super.latexindent}/bin/latexindent -m "$@"
              '';
            })
          ]
        );
      };

      pkgsFor = system: import nixpkgs {
        inherit system;
        overlays = overlayListFor system;
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
        "graphical-${system}" = mkHome { inherit system; graphical = true; };
        "headless-${system}" = mkHome { inherit system; graphical = false; };
      };

      homeConfigurationsBySystem = builtins.foldl'
        (acc: system: acc // homeConfigEntries system)
        { }
        systems;

    in
    {
      inherit overlays;

      homeConfigurations = homeConfigurationsBySystem // {
        graphical = homeConfigurationsBySystem."graphical-x86_64-linux";
        headless = homeConfigurationsBySystem."headless-x86_64-linux";
      };

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
