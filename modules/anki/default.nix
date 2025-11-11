{
  config = {
    programs.anki = {
      enable = true;
      sync = {
        url = "http://fft:27701";
        username = "hippoid";
        autoSync = true;
        syncMedia = true;
        keyFile = "/home/hippoid/.ankiSyncKey";
      };
    };
  };
}
