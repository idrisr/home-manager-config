{
  plugins = {
    lspsaga.enable = false;
    lsp-lines.enable = true;
    lsp = {
      enable = true;
      servers = {
        asm_lsp.enable = true;
        bashls.enable = true;
        ccls.enable = true;
        cssls.enable = true;
        hls = {
          enable = true;
          installGhc = false;
        };
        html.enable = true;
        lemminx.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        gopls.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        # ocamlls.enable = true;
        prolog_ls.enable = false;
        # purescriptls.enable = true;
        pyright.enable = true;
        terraformls.enable = true;
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
                onSave = false;
              };
              chktex = {
                onEdit = true;
                onOpenAndSave = true;
              };
              # forwardSearch = {
              # executable = "zathura";
              # args = [ "--synctex-forward" "%l:1:%f" "./build/%n.pdf" ];
              # };
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
        ts_ls.enable = true;
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
