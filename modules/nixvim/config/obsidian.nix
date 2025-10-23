{
  keymaps = [
    # move to filetype only for zettel
    {
      key = "<leader>of";
      action = ":Obsidian follow_link<cr>";
      mode = "n";
      options = {
        desc = "obsidian follow link";
        silent = false;
      };
    }
    {
      key = "<leader>ob";
      action = ":Obsidian backlinks<cr>";
      mode = "n";
      options = {
        desc = "obsidian back links";
        silent = false;
      };
    }
    {
      key = "<leader>ol";
      action = ":Obsidian links<cr>";
      mode = "n";
      options = {
        desc = "obsidian links";
        silent = false;
      };
    }
    {
      key = "<leader>O";
      action = ":Obsidian today<cr>";
      mode = "n";
      options = {
        desc = "obsidian today";
        silent = false;
      };
    }
    {
      key = "<leader>odt";
      action = ":Obsidian tomorrow<cr>";
      mode = "n";
      options = {
        desc = "obsidian tomorrow";
        silent = false;
      };
    }
    {
      key = "<leader>ody";
      action = ":Obsidian yesterday<cr>";
      mode = "n";
      options = {
        desc = "obsidian yesterday";
        silent = false;
      };
    }
    {
      key = "<leader>os";
      action = "<cmd>Obsidian search<cr>";
      mode = "n";
      options = {
        desc = "obsidian search";
        silent = false;
      };
    }
  ];

  plugins.obsidian = {
    enable = true;
    settings = {
      frontmatter.enable = false;
      legacy_commands = false;

      follow_url_func = ''
        function(url)
        vim.fn.jobstart({"xdg-open", url})  -- linux
        end
      '';

      workspaces = [{
        path = "/home/hippoid/roam-export";
        name = "roam";
      }];

      # note_id_func = ''
      # function(title)
      # return title .. ".md"
      # end
      # '';
    };
  };
}
