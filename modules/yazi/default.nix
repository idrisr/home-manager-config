{ pkgs, ... }: {
  config = {
    programs.yazi = {
      plugins = {
        piper = pkgs.yaziPlugins.piper;
      };

      enable = true;
      settings = {
        mgr = {
          show_hidden = true;
          preview = {
            max_width = 1200;
            max_height = 1000;
          };
        };

        plugin = {
          prepend_previewers = [
            {
              name = "*.srt";
              run = ''piper -- ${pkgs.sorta}/bin/sorta --input "$1"'';
            }
          ];
        };
      };

      keymap = {
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
            on = [ "g" "w" ];
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
            on = [ "g" "s" ];
            run = "cd ~/screenshots/";
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
