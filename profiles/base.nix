{ pkgs, ... }: {
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
      username = "hippoid";
      homeDirectory = "/home/hippoid";
      packages = import ./base-packages.nix pkgs;
    };

    programs = { home-manager.enable = true; };
  };
}
