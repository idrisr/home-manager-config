{
  description = "A nixvim configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { nixvim, flake-utils, nixpkgs, ... }:
    let
      system = flake-utils.lib.system.x86_64-linux;
      nixvimLib = nixvim.lib.${system};
      pkgs = import nixpkgs {
        inherit system;
      };
      nixvim' = nixvim.legacyPackages.${system};
      nixvimModule = {
        inherit system;
        inherit pkgs;
        module = import ./config;
        extraSpecialArgs = {
          graphical = false;
        };
      };
      nvim = nixvim'.makeNixvimWithModule nixvimModule;
    in
    {
      checks.${system}.default =
        nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
      packages.${system}.default = nvim;
      nixosModules.default = nixvimModule;
    };
}
