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
        ];
      };

    in {
      homeConfigurations."hippoid" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ./hyprland-support.nix ];
      };

      homeManagerModules.base = {
        imports = [ ./home.nix ./hyprland-support.nix ];
      };
    };
}
