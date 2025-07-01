{
  description = "reusable home manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur = {
      url = "github:idrisr/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    visualpreview = {
      url = "github:idrisr/visualpreview";
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
    zettel = {
      url = "github:idrisr/zettel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.visualpreview.overlays.visualpreview
          inputs.nur.overlays.${system}
          (import ./modules/qrcp "6969")
          (import ./modules/xournal)
          (import ./modules/tikzit)
          (import ./modules/kdenlive)
          (import ./modules/brave)
          inputs.rofi.overlays.all
          inputs.zettel.overlays.zettel
        ];
      };

    in {
      homeConfigurations."hippoid" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          inputs.nixvim.homeManagerModules.nixvim

          ./modules/nixvim/config

        ];
      };

      homeManagerModules.base = {
        imports = [ ./home.nix inputs.nixvim.homeManagerModules.nixvim ];
      };
    };
}
