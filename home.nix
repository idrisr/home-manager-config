# nixos module entry point to home-manager
{ config, lib, ... }:
let cfg = config.dailydrive.profile;
in {
  imports = [ ./profiles/base.nix ./profiles/desktop.nix ];

  config = {
    profile.dailydrive.enable = true;
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
