{ pkgs, lib, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk # screenshot, file chooser, etc.
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = [ "wlr" ];
  };


  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    systemd.enableXdgAutostart = true;

    settings = {
      "$mod" = "ALT";

      monitor = [
        ", preferred, auto-up, 2"
      ];

      windowrule = [
        "match:class ^(kitty)$, workspace 1"
        "match:class ^(org.pwmt.zathura)$, workspace 2"
        "match:class ^(firefox)$, workspace 3"
        "match:class ^(be.alexandervanhee.gradia)$, workspace 4"
        "match:class ^(org.keepassxc.keepassxc)$, workspace 4"
        "match:class ^(signal)$, workspace 4"
        "match:class ^(org.pulseaudio.pavucontrol)$, workspace 5"
        "match:class ^(reaper)$, workspace 5"
        "match:class ^(org.kde.kdenlive)$, workspace 5"
      ];

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      decoration = {
        rounding = 8;
      };

      misc = {
        on_focus_under_fullscreen = 1;
      };

      animations = {
        enabled = false;
      };

      bind = [
        "$mod, q, workspace, 1"
        "$mod, w, workspace, 2"
        "$mod, e, workspace, 3"
        "$mod, r, workspace, 4"
        "$mod, t, workspace, 5"
        "$mod, j, cyclenext"
        # "$mod, j, focuscurrentorlast"
        "$mod, f, fullscreen, 1"
        "$mod, l, resizeactive, 40 0"
        "$mod, h, resizeactive, -40 0"
        "$mod, k, swapnext"
        "$mod, p, exec, wofi --show drun"
        "$mod shift, n, exec, flameshot gui"

        "$mod shift, b, exec, ${lib.getExe pkgs.qutebrowser}"
        "$mod shift, v, exec, ${lib.getExe pkgs.firefox}"
        "$mod shift, k, exec, ${lib.getExe pkgs.kitty}"
        "$mod, s, exec, ${lib.getExe pkgs.gradia}  --screenshot=INTERACTIVE"

        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"

        "$mod shift, 1, movetoworkspace, 1"
        "$mod shift, 2, movetoworkspace, 2"
        "$mod shift, 3, movetoworkspace, 3"
        "$mod shift, 4, movetoworkspace, 4"
        "$mod shift, 5, movetoworkspace, 5"

        "$mod SHIFT, O, killactive"
        "$mod SHIFT, d, layoutmsg, dwindle"
        "$mod SHIFT, m, layoutmsg, master"
        "$mod SHIFT, f, togglefloating"

        "$mod SHIFT, l, exec, hyprvoice toggle"
      ];
    };

    plugins = [
    ];

    extraConfig = ''
      input {
        touchpad {
          natural_scroll = true
        }
      }

      general {
        gaps_in = 2; # inner gaps
        gaps_out = 4; # outer gaps (to screen edges)
        border_size = 4
      }
      env = XCURSOR_THEME,Bibata-Modern-Classic
      env = XCURSOR_SIZE,24
    '';
  };

  services.hyprshell = {
    enable = false;
    settings = {
      windows = {
        overview = { };
        switch = { };
      };
    };
  };

  home.packages = with pkgs; [
    grim
    hyprpaper
    pamixer
    slurp
    libinput
    sway
    wofi
    evtest
  ];
}
