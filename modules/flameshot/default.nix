{ pkgs, ... }:
{
  config = {
    services.flameshot = {
      enable = true;
      package = pkgs.flameshot.override {
        enableWlrSupport = true;
      };

      settings = {
        General = {
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;
        };
      };
    };
  };
}
