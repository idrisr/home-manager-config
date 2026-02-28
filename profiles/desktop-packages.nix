pkgs:
let
  lib = pkgs.lib;
  commonNames = [
    "age"
    "mdformat"
    "amp-cli"
    "codex"
    "claude-code"
    "code2prompt"
    "ffmpeg_8-full"
    "mermaid-cli"
    "nixpkgs-fmt"
    "ocrmypdf"
    "pdftc"
    "pipe-rename"
    "sorta"
    "sqls"
    "videoChapter"
  ];
  pick = name: if builtins.hasAttr name pkgs then pkgs.${name} else null;
  common = lib.filter (pkg: pkg != null) (map pick commonNames);
  linuxOnly = with pkgs; [
    signal-desktop
    books
    booksDesktopItem
    brave
    droidcam
    cryptsetup
    obsidian
    gimp
    gradia
    inotify-tools
    # kdePackages.krohnkite
    kdePackages.kdenlive
    keepassxc
    libreoffice
    mksession
    minicom
    nerd-fonts.jetbrains-mono
    newcover
    papers
    papersDesktopItem
    # pvm
    reaper
    rofi
    # srtcpy
    techtalk
    techtalkDesktopItem
    transcribe
    # topdf
    # vttclean
    wl-clipboard-rs
    zotero
    telegram-desktop
    pvm
    rnote
    zulip
    # latexindent
  ];
in
common ++ lib.optionals pkgs.stdenv.isLinux linuxOnly
