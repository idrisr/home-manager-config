# nixos module entry point to home-manager
{ inputs, lib, graphical, ... }:
{
  imports = [
    ./profiles/base.nix
  ] ++ lib.optionals graphical [
    ./profiles/desktop.nix
    inputs.stylix.homeModules.stylix
  ];

  config = {
    programs.home-manager.enable = true;
  };
}
