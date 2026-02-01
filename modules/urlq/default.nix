{ pkgs, inputs, ... }:
{
  imports = [
    inputs.urlq.lib.urlq.homeManagerModule
  ];

  services.urlq = {
    enable = true;
    serverPackage = inputs.urlq.packages.${pkgs.stdenv.hostPlatform.system}.urlq-server;
  };
}
