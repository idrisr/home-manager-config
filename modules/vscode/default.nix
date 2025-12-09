{ pkgs, ... }: {
  config = {
    programs.vscode = {
      enable = false;
      package = pkgs.vscode.fhs;
    };
  };
}
