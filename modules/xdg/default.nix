{ pkgs, config, ... }:
let
  firefox = "firefox.desktop";
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
          "text/html" = firefox;
          "image/jpeg" = sxiv;
          "image/png" = sxiv;
          "image/gif" = sxiv;
          "image/webp" = sxiv;
          "image/bmp" = sxiv;
          "image/tiff" = sxiv;
          "x-scheme-handler/about" = firefox;
          "x-scheme-handler/http" = firefox;
          "x-scheme-handler/https" = firefox;
          "x-scheme-handler/unknown" = firefox;
        };
      };
    };
  };
}
