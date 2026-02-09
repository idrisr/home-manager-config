{ inputs, ... }:
{
  imports = [
    inputs.hyprvoice.homeManagerModules.default
  ];

  services.hyprvoice.enable = true;
}
