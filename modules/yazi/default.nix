{ pkgs, ... }: {
  config = {
    home.packages = with pkgs; [ ouch miller ];
    programs.yazi = {
      plugins = {
        piper = pkgs.yaziPlugins.piper;
        ouch = pkgs.yaziPlugins.ouch;
        miller = pkgs.yaziPlugins.miller;
        video-chapter = ./plugins/video-chapter.yazi/main.lua;
        pdf-fit = ./plugins/pdf-fit.yazi/main.lua;
      };

      enable = true;
      settings = {
        mgr = {
          show_hidden = true;
          ratio = [ 1 2 4 ];
          preview = {
            max_width = 1200;
            max_height = 1000;
          };
        };
        opener = {
          edit = [{
            run = ''nvim "$@"'';
            block = true;
          }];
        };

        open = {
          prepend_rules = [
            { url = "*.srt"; use = "edit"; }
          ];
        };

        plugin = {
          prepend_previewers = [
            {
              url = "*.srt";
              run = ''piper -- ${pkgs.sorta}/bin/sorta --input "$1"'';
            }
            { mime = "video/*"; run = "video-chapter"; }
            { mime = "application/*zip"; run = "ouch"; }
            { mime = "application/x-tar"; run = "ouch"; }
            { mime = "application/x-bzip2"; run = "ouch"; }
            { mime = "application/x-7z-compressed"; run = "ouch"; }
            { mime = "application/x-rar"; run = "ouch"; }
            { mime = "application/vnd.rar"; run = "ouch"; }
            { mime = "application/x-xz"; run = "ouch"; }
            { mime = "application/xz"; run = "ouch"; }
            { mime = "application/x-zstd"; run = "ouch"; }
            { mime = "application/zstd"; run = "ouch"; }
            { mime = "application/java-archive"; run = "ouch"; }
            { mime = "text/csv"; run = "miller"; }
          ];
        };
      };

      keymap = {
        mgr.prepend_keymap = [
          { run = "quit"; on = [ "q" ]; }
          { on = [ "g" "v" ]; run = "cd ~/videos"; }
          { on = [ "g" "f" ]; run = "cd ~/fun"; }
          { on = [ "g" "b" ]; run = "cd ~/books"; }
          { on = [ "g" "w" ]; run = "cd ~/downloads"; }
          { on = [ "g" "t" ]; run = "cd ~/documents/tech-talks/"; }
          { on = [ "g" "p" ]; run = "cd ~/documents/papers/"; }
          { on = [ "g" "r" ]; run = "cd ~/roam-export/"; }
          { on = [ "g" "s" ]; run = "cd ~/screenshots/"; }
          { on = [ "g" "f" ]; run = "cd ~/.config/fabric/"; }
          {
            on = [ "g" "L" ];
            run = ''shell '${pkgs.sorta}/bin/sorta --input "$1" | wl-copy' '';
          }
        ];
      };
    };
  };
}
