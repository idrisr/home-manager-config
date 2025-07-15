{ pkgs, ... }: {
  imports = [
    ./base.nix
    ../modules/alacritty
    ../modules/firefox
    ../modules/ctags
    ../modules/github
    ../modules/haskeline
    ../modules/kitty
    ../modules/flameshot
    ../modules/hyprland
    ../modules/hyprcursor
    ../modules/lsd
    ../modules/obs
    ../modules/mpv
    ../modules/opentablet
    ../modules/pandoc
    ../modules/polybar
    ../modules/pipewire
    ../modules/qt
    ../modules/qutebrowser
    # ../modules/rofi
    ../modules/vscode
    ../modules/waybar
    ../modules/xdg
    ../modules/yt-dlp
    ../modules/zathura
    ../modules/zoxide
  ];

  config = {
    home = {
      username = "hippoid";
      homeDirectory = "/home/hippoid";
      packages = import ./desktop-packages.nix pkgs;
    };
    xresources.properties = {
      "Xft.autohint" = 0;
      "Xft.hintstyle" = "hintfull";
      "Xft.hinting" = 1;
      "Xft.antialias" = 1;
      "Xft.rgba" = "rgb";
      "Xft.dpi" = 180;
    };
    services = {
      screen-locker = {
        enable = true;
        lockCmd =
          "${pkgs.i3lock}/bin/i3lock --nofork --color=000000 --ignore-empty-password --show-failed-attempts";
        inactiveInterval = 15;
      };
      poweralertd.enable = true;
    };
  };
}
