{ pkgs, ... }: {
  imports = [
    ./base.nix
    ../modules/alacritty
    ../modules/anki
    ../modules/ctags
    ../modules/dunst
    ../modules/fabric
    ../modules/firefox
    ../modules/flameshot
    ../modules/github
    ../modules/haskeline
    ../modules/hyprcursor
    ../modules/hyprland
    ../modules/kitty
    ../modules/lsd
    ../modules/mpv
    ../modules/obs
    ../modules/opentablet
    ../modules/pandoc
    ../modules/pipewire
    ../modules/polybar
    ../modules/qt
    ../modules/qutebrowser
    # ../modules/rofi
    ../modules/vscode
    ../modules/waybar
    ../modules/xdg
    ../modules/yazi
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
