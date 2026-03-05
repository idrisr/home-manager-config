{
  programs.mcp = {
    enable = true;
    servers = {
      nixos = {
        command = "nix";
        args = [ "run" "github:utensils/mcp-nixos" "--" ];
      };
      redmine = {
        command =
          "/nix/store/q2jh184igwbglpbxihlmp7c30x7afjkz-python3.13-mcp-redmine-2026.01.13.152335/bin/mcp-redmine";
        env =
          {
            REDMINE_URL = "http://fft:3001";
            REDMINE_API_KEY = "e0e6b4b753ad76722c9d677a0b1daca582baf2a4";
          };
      };
      context7 = {
        url = "https://mcp.context7.com/mcp";
      };
    };
  };

  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      # model = "kimi-for-coding/k2p5";
      autoshare = false;
      autoupdate = true;
    };
  };
}
