{ config, inputs, ... }:
{
  imports = [
    # inputs.urlq.lib.urlq.homeManagerModule
  ];

  # services.urlq = {
  # enable = true;
  # transcribe = {
  # enable = true;
  # watchDir = "${config.home.homeDirectory}/videos";
  # };
  # };
}
