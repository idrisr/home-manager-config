{ pkgs, lib, graphical ? false, ... }:

lib.optionalAttrs graphical {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/selenized-dark.yaml";
  };
}
