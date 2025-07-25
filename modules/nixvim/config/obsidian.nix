{
  keymaps = [
    # move to filetype only for zettel
    {
      key = "<leader>of";
      action = ":ObsidianFollowLink<cr>";
      mode = "n";
      options = {
        desc = "obsidian follow link";
        silent = false;
      };
    }
    {
      key = "<leader>ob";
      action = ":ObsidianBacklinks<cr>";
      mode = "n";
      options = {
        desc = "obsidian back links";
        silent = false;
      };
    }
    {
      key = "<leader>ol";
      action = ":ObsidianLinks<cr>";
      mode = "n";
      options = {
        desc = "obsidian links";
        silent = false;
      };
    }
    {
      key = "<leader>O";
      action = ":ObsidianToday<cr>";
      mode = "n";
      options = {
        desc = "obsidian today";
        silent = false;
      };
    }
    {
      key = "<leader>odt";
      action = ":ObsidianTomorrow<cr>";
      mode = "n";
      options = {
        desc = "obsidian tomorrow";
        silent = false;
      };
    }
    {
      key = "<leader>ody";
      action = ":ObsidianYesterday<cr>";
      mode = "n";
      options = {
        desc = "obsidian yesterday";
        silent = false;
      };
    }
    {
      key = "<leader>os";
      action = "<cmd>ObsidianSearch<cr>";
      mode = "n";
      options = {
        desc = "obsidian tomorrow";
        silent = false;
      };
    }
  ];

  plugins.obsidian = {
    enable = true;
    settings = {
      disable_frontmatter = true;
      follow_url_func = ''
        function(url)
          vim.fn.jobstart({"xdg-open", url})  -- linux
        end
      '';
      workspaces = [{
        path = "/home/hippoid/roam-export";
        name = "roam";
      }];
      note_id_func = ''
        function(title)
            return title .. ".md"
        end
      '';
    };
  };
}
