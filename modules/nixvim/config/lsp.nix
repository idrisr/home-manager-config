{
  plugins = {
    lspsaga.enable = false;
    lsp-lines.enable = true;
    lsp = {
      enable = true;
      servers = {
        hls = {
          enable = false;
          installGhc = false;
        };

        leanls.enable = true;
        nil_ls = {
          enable = true;
          settings.nix.flake.autoArchive = true;
        };

        texlab = {
          enable = true;
          settings = {
            texlab = {
              bibtexFormatter = "texlab";
              build = {
                # assumes main config in local latexmkrc
                args = [ "-pvc" "%f" ];
                executable = "latexmk";
                forwardSearchAfter = true;
                onSave = true;
              };
              latexindent = {
                modifyLineBreaks = true;
              };
              chktex = {
                onEdit = true;
                onOpenAndSave = true;
              };
              symbols.customEnvironments = [
                {
                  name = "definition";
                  displayName = "definition";
                }
                {
                  name = "example";
                  displayName = "example";
                }
                {
                  name = "intuition";
                  displayName = "intuition";
                }
                {
                  name = "exercise";
                  displayName = "exercise";
                }
                {
                  name = "haskell";
                  displayName = "haskell";
                }
              ];
            };
          };
        };
      };

      keymaps = {
        diagnostic = { "<space>q" = "setloclist"; };
        lspBuf = {
          K = "hover";
          "<leader>gr" = "references";
          "<leader>gd" = "definition";
          "<leader>gt" = "type_definition";
          "<leader>ga" = "code_action";
        };
      };
    };
  };
}
