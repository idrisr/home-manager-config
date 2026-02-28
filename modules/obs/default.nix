{ pkgs, ... }: {
  config = {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins;
        [
          obs-advanced-masks
          obs-pipewire-audio-capture
          obs-source-record
          obs-vkcapture
          droidcam-obs
        ];
    };
  };
}
