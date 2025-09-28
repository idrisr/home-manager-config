{ pkgs, ... }: {
  config = {
    home.packages = with pkgs; [ libnotify ];
    services.dunst = {
      enable = true;
    };
  };
}
