{ pkgs, ... }: {
  home.packages = [ pkgs.mp3gain ];
  programs.beets = {
    enable = true;

    settings = {
      replaygain = {
        backend = "command";
        command = "mp3gain";
        auto = true;
      };

      plugins = [
        "fetchart"
        "embedart"
        "lyrics"
        "replaygain"
        "scrub"
      ];
    };
  };
}
