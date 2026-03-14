{
  autoGroups = {
    bash = {
      clear = true;
    };
    nix = {
      clear = true;
    };
    help = {
      clear = true;
    };
    haskell = {
      clear = true;
    };
    tex = {
      clear = true;
    };
  };

  autoCmd = [
    {
      event = [ "FileType" ];
      pattern = [ "nix" ];
      command = "setlocal makeprg=nix\\ eval\\ -f\\ \\%";
      group = "nix";
      desc = "nix";
    }

    {
      event = [ "FileType" ];
      pattern = [ "nix" ];
      command = "setlocal foldlevel=4";
      group = "nix";
    }

    {
      event = [ "FileType" ];
      pattern = [ "help" ];
      command = "setlocal number buflisted";
      group = "help";
    }

    {
      event = [ "FileType" ];
      pattern = [ "haskell" ];
      command = "setlocal foldlevel=99";
      group = "haskell";
    }
    {
      event = [ "BufNewFile" "BufRead" ];
      pattern = [ "*.sh" ];
      command = "setlocal makeprg=bash\\ -f\\ \\%\\ $*";
      group = "bash";
    }

    {
      event = [ "BufEnter" ];
      pattern = [ "*.tex" ];
      command = ":setlocal textwidth=0";
      group = "tex";
    }
    {
      event = [ "BufEnter" ];
      pattern = [ "*.purs" ];
      command = ":setlocal filetype=purescript";
    }
    {
      event = [ "BufEnter" ];
      pattern = [ "*.pl" ];
      command = ":setlocal filetype=prolog";
    }
  ];
}
