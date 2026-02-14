{ pkgs, ... }:
let
  username = "hippoid";
  homeDirectory =
    if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
in {
  imports = [
    ../modules/atuin
    ../modules/bat
    ../modules/direnv
    ../modules/fzf
    ../modules/git
    ../modules/lazygit
    ../modules/readline
    ../modules/ripgrep
    ../modules/starship
    ../modules/tmux
    ../modules/vifm
    ../modules/zsh
    ../modules/stylix
  ];

  config = {
    home = {
      stateVersion = "25.05";
      inherit username homeDirectory;
      packages = import ./base-packages.nix pkgs;
    };

    programs = { home-manager.enable = true; };
  };
}
