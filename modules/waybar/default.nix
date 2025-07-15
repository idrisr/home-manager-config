{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 10;
        output = [
          "eDP-1"
        ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "network" ];
        modules-right = [ "pulseaudio" "temperature" "cpu" "battery" "clock" ];

        "hyprland/workspaces" = {
          all-outputs = true;
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
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        cpu = {
          interval = 1;
          format = "{usage}% ";
          max-length = 10;
        };

      };
    };
  };
}
