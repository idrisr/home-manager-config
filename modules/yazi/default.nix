{ ... }: {
  config = {
    programs.yazi = {
      enable = true;
      settings = {
        mgr = {
          show_hidden = true;
        };
        preview = {
          max_width = 1200;
          max_height = 1000;
        };
        opener = { };
      };

      keymap = {
        input.prepend_keymap = [ ];

        mgr = {
          prepend_keymap = [
            { run = "quit"; on = [ "q" ]; }
          ];
        };
      };
    };
  };
}
