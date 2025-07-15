# nixos module entry point to home-manager
{ config, lib, graphical, ... }:
{
  imports = [
    ./profiles/base.nix
  ] ++ lib.optionals graphical [ ./profiles/desktop.nix ];

  config = {
    programs.home-manager.enable = true;
  };

  options = {
    profile = {
      dailydrive = {
        enable = lib.mkOption {
          default = true;
          type = lib.types.bool;
          description = lib.mdDoc ''
            enable the full tools needed for a user for some banging system
          '';
        };
      };
    };
  };
}
