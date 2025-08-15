{
  config = {
    programs = {
      yt-dlp = {
        enable = true;
        extraConfig = ''
          --paths=home:~/videos/
          --paths=temp:/tmp/
          --convert-subs srt
        '';

        settings = {
          write-auto-subs = true;
          write-subs = true;
          embed-chapters = true;
          sub-langs = "en";
          downloader = "aria2c";
          downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
          output = ''%(uploader)s-%(title)s-[%(id)s].%(ext)s'';
          restrict-filenames = true;
        };
      };
    };
  };
}
