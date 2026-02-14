{ pkgs, lib, ... }: {
  imports = [
    ./base.nix
    ../modules/alacritty
    ../modules/anki
    ../modules/ctags
    ../modules/fabric
    ../modules/github
    ../modules/haskeline
    ../modules/kitty
    ../modules/lsd
    ../modules/mpv
    ../modules/opencode
    ../modules/pandoc
    ../modules/qutebrowser
    ../modules/vscode
    ../modules/yazi
    ../modules/yt-dlp
    ../modules/zoxide
  ]
  ++ lib.optionals pkgs.stdenv.isLinux [
    ../modules/dunst
    ../modules/firefox
    ../modules/flameshot
    ../modules/hyprcursor
    ../modules/hyprland
    ../modules/hyprvoice
    ../modules/obs
    ../modules/opentablet
    ../modules/pipewire
    ../modules/polybar
    ../modules/qt
    # ../modules/rofi
    ../modules/urlq
    ../modules/waybar
    ../modules/xdg
    ../modules/zathura
  ];

  config = {
    home.packages = import ./desktop-packages.nix pkgs;
  }
  // lib.optionalAttrs pkgs.stdenv.isLinux {
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
      poweralertd.enable = false;
    };
  };
}
