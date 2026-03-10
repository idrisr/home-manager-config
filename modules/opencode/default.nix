{
  programs.mcp = {
    enable = true;
    servers = {
      nixos = {
        command = "nix";
        args = [ "run" "github:utensils/mcp-nixos" "--" ];
      };
      context7 = {
        url = "https://mcp.context7.com/mcp";
      };
    };
  };

  programs.opencode =
    {
      enable = true;
      web = {
        enable = true;
      };
      enableMcpIntegration = true;
      settings =
        {
          autoshare = false;
          autoupdate = true;
          provider = {
            ollama = {
              npm = "@ai-sdk/openai-compatible";
              name = "Ollama";
              options = {
                baseURL = "http://fft:11111/v1";
              };
              models = {
                "qwen3:8b" = {
                  name = "qwen3:8b";
                };
              };
            };
          };
        };
    };
}
