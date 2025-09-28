{ pkgs, ... }:
let
  concatFiles = files:
    let
      j = map builtins.readFile files;
      k = builtins.concatStringsSep "\n" ([ " " ] ++ j);
    in
    k;
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
      ./parinfer.nix
      ./persistence.nix
      ./render-markdown.nix
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
      kmonad-vim
      nvim-dap-ui
      outline-nvim
      telescope_hoogle
      pkgs.zettel
      nvim-treesitter-parsers.yuck
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
