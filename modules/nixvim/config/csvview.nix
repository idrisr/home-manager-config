{
  plugins.csvview = {
    enable = true;
    settings = {
      parser = { async_chunksize = 30; };
      view = {
        display_mode = "border";
        spacing = 4;
      };
    };
  };
}
