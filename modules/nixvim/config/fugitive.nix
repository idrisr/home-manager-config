{
  plugins.fugitive.enable = true;

  plugins.gitsigns.enable = true;
  plugins.neogit.enable = false;
  plugins.diffview.enable = true;
  keymaps = [
    {
      key = "<leader>gl";
      action = '':Git log --relative --pretty=format:"%h %as %ar %s" %<cr>'';
      mode = "n";
    }
    {
      key = "<leader>gB";
      action = ":Git blame --date relative %<cr>";
      mode = "n";
      options = { desc = "Show git history with relative dates"; };
    }
    {
      key = "<leader>gL";
      action = ":tab Git log --follow -p %<cr>";
      mode = "n";
    }
  ];
}
