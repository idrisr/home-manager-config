{ pkgs, ... }: {
  home.packages = with pkgs; [
    crosspipe
    easyeffects
    pulseaudio
  ];
}
