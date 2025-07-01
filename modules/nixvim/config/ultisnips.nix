{ pkgs, ... }: {
  extraPlugins = [ pkgs.vimPlugins.ultisnips ];
  keymaps = [{
    key = "<leader>u";
    action = ":call UltiSnips#RefreshSnippets()<CR>";
    mode = "n";
  }];
  globals = { UltiSnipsSnippetDirectories = [ ./snippets ]; };
}
