{ pkgs, ... }:
{
  home.pointerCursor = {
    name = "Bibata-Modern-Classic"; # match installed theme
    package = pkgs.bibata-cursors;
    size = 12;
    gtk.enable = true;
    x11.enable = true; # still needed even on Wayland
  };

  home.packages = [ pkgs.bibata-cursors ];
}
