{ config, ... }:
{
  config = {
    programs.anki = {
      enable = true;
      sync = {
        url = "http://fft:27701";
        username = "hippoid";
        autoSync = true;
        syncMedia = true;
        keyFile = "${config.home.homeDirectory}/.ankiSyncKey";
      };
    };
  };
}
