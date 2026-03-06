{ ... }: {
  programs.television = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.nix-search-tv = {
    enable = true;
    enableTelevisionIntegration = true;
  };
}
