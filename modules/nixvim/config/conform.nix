{ pkgs, lib, ... }:
{
  plugins = {
    lint = {
      enable = true;
      lintersByFt = { tex = [ "chktex" ]; };
      autoCmd = {
        callback = {
          __raw = ''
            function()
              require('lint').try_lint()
            end
          '';
        };
        event = "BufWritePost";
      };
    };
    conform-nvim = {
      enable = true;
      settings = {
        format_after_save = "true";
        notify_on_error = true;
        quiet = false;
        async = true;
        formatters_by_ft = {
          bib = [ "bibtex-tidy" ];
          c = [ "clang-format" ];
          cabal = [ "cabal_fmt" ];
          haskell = [ "fourmolu" ];
          html = [ "htmlbeautifier" ];
          javascript = [ "prettierd" ];
          jsonc = [ "fixjson" ];
          json = [ "fixjson" ];
          md = [ "mdformat" ];
          lua = [ "stylua" ];
          nix = [ "nixpkgs-fmt" ];
          ocaml = [ "ocamlformat" ];
          purescript = [ "purescriptls" ];
          python = [ "isort" "black" ];
          rust = [ "rustfmt" ];
          sql = [ "sqlfluff" ];
          terraform = [ "terraform_fmt" ];
          tex = [ "latexindent" ];
          text = [ ];
          typescript = [ "prettierd" ];
          "*" = [ "trim_newlines" "trim_whitespace" ];
        };
        formatters = {
          nixpkgs-fmt = {
            command = lib.getExe pkgs.nixpkgs-fmt;
          };
          rustfmt = {
            command = lib.getExe pkgs.rustfmt;
          };
          sqlfluff = {
            command = lib.getExe pkgs.sqlfluff;
          };
          mdformat = {
            command = "${lib.getExe pkgs.mdformat}";
            args = [ "--wrap" 80 ];
          };
        };
      };
    };
  };
}
