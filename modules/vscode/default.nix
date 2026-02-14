{ pkgs, ... }: {
  config = {
    programs.vscode = {
      enable = false;
      package = if pkgs.stdenv.isLinux then pkgs.vscode.fhs else pkgs.vscode;
    };
  };
}
