# nixos module entry point to home-manager
{ pkgs, inputs, graphical, ... }:
let lib = pkgs.lib; in
{
  imports = [
    ./profiles/base.nix
    ./modules/nixvim/config
    inputs.nixvim.homeModules.nixvim
  ]
  ++ lib.optionals graphical [
    ./profiles/desktop.nix
  ]
  ++ lib.optionals (graphical && pkgs.stdenv.isLinux) [
    inputs.stylix.homeModules.stylix
  ];

  config = {
    nix.registry.idris.flake = inputs.idris-pkgs;
    nix.registry.idris-pkgs.flake = inputs.idris-pkgs;
    nix.registry.llm.to = {
      type = "github";
      owner = "numtide";
      repo = "llm-agents.nix";
    };
    nix.registry.ros.to = {
      type = "github";
      owner = "lopsided98";
      repo = "nix-ros-overlay";
    };

    programs.home-manager.enable = true;
  };
}
