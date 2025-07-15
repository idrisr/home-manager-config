{ ... }: {
  # stylix.targets.kitty.enable = false;
  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      sync_to_monitor = "no";
      input_delay = 1;
      # background_opacity = 0.8;
    };
  };
}
