{ pkgs, ... }:
{
  plugins = {
    lspsaga.enable = false;
    lsp-lines.enable = true;
    lsp = {
      enable = true;
      servers = {
        asm_lsp.enable = true;
        bashls.enable = true;
        ccls.enable = false;
        cssls.enable = true;
        hls = {
          enable = false;
          installGhc = false;
        };
        html.enable = true;
        lemminx.enable = true;
        jdtls.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        gopls.enable = true;
        marksman.enable = true;
        nil_ls = {
          enable = true;
          settings.nix.flake.autoArchive = true;
        };

        prolog_ls.enable = false;
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        sqls.enable = true;
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
