# nixos module entry point to home-manager
{ pkgs, inputs, graphical, ... }:
let lib = pkgs.lib; in
{
  imports = [
    ./profiles/base.nix
    ./modules/nixvim/config
    inputs.nixvim.homeModules.nixvim
  ] ++ lib.optionals graphical [
    ./profiles/desktop.nix
    inputs.stylix.homeModules.stylix
  ];

  config = {
    programs.home-manager.enable = true;
  };
}
