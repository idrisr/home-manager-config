{ config, pkgs, ... }:
{
  config = {
    programs.anki = {
      addons = [ pkgs.ankiAddons.anki-connect ];
      enable = true;
      profiles."User 1".sync = {
        url = "http://fft:27701";
        username = "hippoid";
        autoSync = true;
        syncMedia = true;
        keyFile = "${config.home.homeDirectory}/.ankiSyncKey";
      };
    };
  };
}
