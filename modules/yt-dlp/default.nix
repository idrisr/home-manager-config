{
  config = {
    programs = {
      yt-dlp = {
        enable = true;
        extraConfig = ''
          --paths=home:~/videos/
          --paths=temp:/tmp/
        '';

        settings = {
          embed-chapters = true;
          downloader = "aria2c";
          downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
          output = ''%(release_date)s-%(title)s-%(view_count)s.%(ext)s'';
          restrict-filenames = true;
          sub-langs = "en";
          write-subs = true;
          write-auto-subs = true;
          convert-subs = "srt";
          no-playlist = true;
        };
      };
    };
  };
}
