{ pkgs, lib, graphical ? false, ... }:

lib.optionalAttrs (graphical && pkgs.stdenv.isLinux) {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/selenized-dark.yaml";
    targets.firefox.profileNames = [ "hippoid" ];
  };
}
