{ pkgs, ... }:
let
  concatFiles = files:
    let
      j = map builtins.readFile files;
      k = builtins.concatStringsSep "\n" ([ " " ] ++ j);
    in
    k;
  vim-sqls = pkgs.vimUtils.buildVimPlugin {
    name = "sqls";
    src = pkgs.fetchFromGitHub {
      repo = "sqls.vim";
      owner = "sqls-server";
      rev = "9455c25cf724417584b32cb843cc20be8e56e6bf";
      sha256 = "sha256-UldNbKG9D6gmcnpXtaiVybGGzzgrrgVBNLCXZGHLpnY=";
    };
  };
  # https://github.com/sqls-server/sqls.vim
in
{
  programs.nixvim = {
    enable = true;
    imports = [
      ./align.nix
      ./alpha.nix
      ./autocommand.nix
      ./autosession.nix
      ./avante.nix
      ./cmp.nix
      ./comment.nix
      ./conform.nix
      ./cornelis.nix
      ./csvview.nix
      ./dadbod.nix
      ./dap.nix
      ./dot.nix
      ./emmet.nix
      ./fugitive.nix
      ./fzf.nix
      ./keymap.nix
      ./latex.nix
      ./lean
      ./lsp.nix
      ./neoscroll.nix
      ./neo-tree.nix
      ./notify.nix
      ./obsidian.nix
      ./oil.nix
      ./ollama.nix
      ./opencode.nix
      ./parinfer.nix
      ./persistence.nix
      ./project.nix
      ./render-markdown.nix
      ./slime.nix
      ./surround.nix
      ./telescope.nix
      ./treesitter.nix
      ./toggleterm.nix
      ./transparent.nix
      ./trouble.nix
      ./ultisnips.nix # move to other snip thing
      ./vimrc.nix
      ./whichkey.nix
      ./yazi.nix
    ];

    viAlias = true;
    vimAlias = true;

    extraPlugins = with pkgs.vimPlugins; [
      fzf-vim # switch to fzf-lua?
      img-clip-nvim
      julia-vim
      kmonad-vim
      lean-nvim
      matchit-zip
      nvim-dap-ui
      nvim-treesitter-parsers.yuck
      outline-nvim
      pkgs.zettel
      telescope_hoogle
      vim-pencil
      vim-sqls
      yuck-vim
    ];

    extraConfigVim = concatFiles [ ./vimrc ];
    extraConfigLua = concatFiles [
      ./init.lua
      ./cmp.lua
      ./surround.lua
      ./debug-adapter.lua
      ./lua-plugin/telescope.lua
    ];
  };
}
