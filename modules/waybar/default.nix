{ pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: Source Code Pro;
      }

      window#waybar {
        background: #16191C;
        color: #AAB2BF;
      }

      #workspaces button {
        padding: 0 5px;
      }

      * {
        font-family: "FiraCode Nerd Font", "Symbols Nerd Font Mono";
      }

    '';

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 10;
        output = [
          "eDP-1"
        ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [
          "systemd-failed-units"
          "battery"
          "wireplumber"
          "privacy"
          "disk"
          "temperature"
        ];
        modules-right = [ "cpu" "clock" ];

        "hyprland/workspaces" = {
          all-outputs = true;
        };

        wireplumber = {
          format = "VOL:{volume}%";
          format-muted = "";
          on-click = "${lib.getExe pkgs.pavucontrol}";
          max-volume = 150;
          scroll-step = 0.2;
        };

        temperature = {
          format = "{temperatureF}°F";
          thermal-zone = 5;
        };

        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "BATT:{capacity}%";
        };

        clock = {
          format = "{:%H:%M}  ";
          format-alt = "{:%A; %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        systemd-failed-units = {
          hide-on-ok = false;
          format = "✗{nr_failed}";
          format-ok = "✓";
          system = true;
          user = false;
        };

        cpu = {
          interval = 5;
          format = "CPU:{usage}%";
          max-length = 10;
        };

        privacy = {
          icon-spacing = 4;
          icon-size = 18;
          transition-duration = 250;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-out";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-in";
              tooltip = true;
              tooltip-icon-size = 24;
            }
          ];
          ignore-monitor = true;
          ignore = [
            {
              type = "audio-in";
              name = "cava";
            }
            {
              type = "screenshare";
              name = "obs";
            }
          ];
        };

        disk = {
          interval = 30;
          format = "{path}:{percentage_used}%";
          path = "/";
        };
      };
    };
  };
}
