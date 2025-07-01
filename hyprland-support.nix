{ pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  home.packages = with pkgs; [ kitty swaylock wl-clipboard rofi-wayland ];
  xdg.enable = true;
  programs.zsh.enable = true;
  home.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  # optional: hyprland config file stub
  xdg.configFile."hypr/hyprland.conf".text = ''
    monitor=,preferred,auto,1
    exec-once = kitty
  '';
}
