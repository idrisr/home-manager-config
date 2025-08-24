{ pkgs, config, ... }:
let
  qute = "org.qutebrave.qutebrave.desktop";
  # spreadsheet = "libreoffice-calc.desktop";
  pdf = "org.pwmt.zathura.desktop";
  sxiv = "sxiv.desktop";
in
{
  config = {
    home.packages = [ pkgs.sxiv ];
    xdg = {
      enable = true;

      userDirs = {
        createDirectories = true;
        enable = true;
        documents = "${config.home.homeDirectory}/documents";
        download = "${config.home.homeDirectory}/downloads";
        music = "${config.home.homeDirectory}/music";
        pictures = "${config.home.homeDirectory}/pictures";
        videos = "${config.home.homeDirectory}/videos";
        desktop = "${config.home.homeDirectory}/desktop";
        templates = "${config.home.homeDirectory}/templates";
      };

      mimeApps = {
        enable = true;
        defaultApplications = {
          "application/pdf" = pdf;
          "text/html" = qute;
          "image/jpeg" = sxiv;
          "image/png" = sxiv;
          "image/gif" = sxiv;
          "image/webp" = sxiv;
          "image/bmp" = sxiv;
          "image/tiff" = sxiv;
          "x-scheme-handler/about" = qute;
          "x-scheme-handler/http" = qute;
          "x-scheme-handler/https" = qute;
          "x-scheme-handler/unknown" = qute;
        };
      };
    };
  };
}
