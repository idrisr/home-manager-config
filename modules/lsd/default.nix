{
  config = {
    programs.lsd = {
      enable = true;
      settings = {
        date = "relative";
        total-size = true;
      };
    };
  };
}
