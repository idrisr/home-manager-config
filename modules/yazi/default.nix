{ pkgs, ... }: {
  config = {
    programs.yazi = {
      enable = true;

      settings = {
        mgr = {
          show_hidden = true;


          preview = {
            max_width = 1200;
            max_height = 1000;
          };

        };
      };

      keymap = {
        input.prepend_keymap = [
        ];
        mgr.prepend_keymap = [
          { run = "quit"; on = [ "q" ]; }
          {
            on = [ "g" "v" ];
            run = "cd ~/videos";
          }
          {
            on = [ "g" "b" ];
            run = "cd ~/books";
          }
          {
            on = [ "g" "d" ];
            run = "cd ~/downloads";
          }
          {
            on = [ "g" "t" ];
            run = "cd ~/documents/tech-talks/";
          }
          {
            on = [ "g" "p" ];
            run = "cd ~/documents/papers/";
          }
          {
            on = [ "g" "r" ];
            run = "cd ~/roam-export/";
          }
          {
            on = [ "g" "L" ];
            run = ''shell '${pkgs.sorta}/bin/sorta --input "$1" | wl-copy' '';
          }
        ];
      };
    };
  };
}
