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
          lua = [ "stylua" ];
          nix = [ "nixpkgs-fmt" ];
          ocaml = [ "ocamlformat" ];
          purescript = [ "purescriptls" ];
          python = [ "isort" "black" ];
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
          sqlfluff = {
            command = lib.getExe pkgs.sqlfluff;
          };
        };
      };
    };
  };
}
