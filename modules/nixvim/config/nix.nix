{
  files = {
    "ftplugin/nix.lua" = {
      opts = {
        makeprg = "nix eval --file %";
      };
    };
  };
}
