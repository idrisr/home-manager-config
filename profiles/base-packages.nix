pkgs:
let
  lib = pkgs.lib;
  commonNames = [
    "fd"
    "file"
    "htop"
    "jq"
    "ncdu"
    "pipe-rename"
    "tmux"
    "trash-cli"
    "tree"
  ];
  linuxOnlyNames = [
    "sysz"
  ];
  pick = name: if builtins.hasAttr name pkgs then pkgs.${name} else null;
  common = lib.filter (pkg: pkg != null) (map pick commonNames);
  linuxOnly = lib.filter (pkg: pkg != null) (map pick linuxOnlyNames);
in
common ++ lib.optionals pkgs.stdenv.isLinux linuxOnly
