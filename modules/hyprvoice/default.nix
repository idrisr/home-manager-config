{ inputs, ... }:
{
  imports = [
    inputs.idris-pkgs.homeManagerModules.hyprvoice
  ];

  services.hyprvoice.enable = true;
}
