{
  lsp.servers = {
    hls.enable = true;
    bashls.enable = true;
    leanls.enable = true;
    nil_ls.enable = true;
    lua_ls.enable = true;
    jsonls.enable = true;
    superhtml.enable = true;
    texlab = {
      enable = true;
      config = {
        settings = {
          bibtexFormatter = "texlab";
          build = {
            # assumes main config in local latexmkrc
            args = [ "-pvc" "%f" ];
            executable = "latexmk";
            forwardSearchAfter = true;
            onSave = false;
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

  plugins = {
    lspsaga.enable = false;
    lsp-lines.enable = true;
    lsp = {
      enable = true;
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
