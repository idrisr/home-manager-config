{ pkgs, ... }:
let mpv-speed-script = pkgs.callPackage ./plugin.nix { };
in {
  programs.mpv = {
    enable = true;
    config = {
      hwdec = "vaapi";
      vo = "gpu";
      screenshot-template = "~/screenshots/%F-%wH.%wM.%wS";
      save-position-on-quit = true;
      keep-open = true;
      gpu-api = "opengl";
      hr-seek = true;
      hr-seek-framedrop = false;
    };
    scripts = [ mpv-speed-script ];
  };
}
