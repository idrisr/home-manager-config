{ config, inputs, ... }:
{
  imports = [
    inputs.idris-pkgs.homeManagerModules.urlq
  ];

  services.urlq = {
    enable = true;
    transcribe = {
      enable = true;
      watchDir = "${config.home.homeDirectory}/videos";
    };
  };
}
