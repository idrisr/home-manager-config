{
  description = "reusable home manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    stylix = {
      url = "github:danth/stylix";
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

      overlays = [
        inputs.visualpreview.overlays.visualpreview
        inputs.nur.overlays.${system}
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

      modules = [
        ./home.nix
        inputs.nixvim.homeManagerModules.nixvim
        ./modules/nixvim/config
        inputs.stylix.homeModules.stylix
      ];
    in
    {
      homeConfigurations = {
        "graphical" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = modules;

          extraSpecialArgs = {
            inherit inputs;
            graphical = true;
          };
        };

        "headless" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = modules ++ [
            { profile.dailydrive.enable = false; }
          ];

          extraSpecialArgs = {
            inherit inputs;
            graphical = false;
          };
        };
      };

      overlays.default = overlays;

      homeManagerModules.base = {
        imports = modules;
      };
    };
}
