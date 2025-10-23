{ config, ... }:
# todo: fixme so it figures out light/dark from colorscheme
let isLight = false;
in {

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      light = isLight;
    };
  };

  programs.git = {
    enable = true;

    settings = {
      core = { editor = "vim"; };
      pull = { rebase = "false"; };
      init = { defaultBranch = "main"; };
      merge = { conflictstyle = "diff3"; };
      diff = { colorMoved = "default"; };
      add.interactive = { useBuiltin = false; };
      format = {
        pretty = ''
          Commit:  %C(yellow)%H%nAuthor:  %C(green)%aN
                <%aE>%nDate: (%C(red)%ar%Creset) %ai%nSubject: %s%n%n%b'';
      };
      user = {
        email = "idris.raja@gmail.com";
        name = "Idris Raja";
      };
      alias = {
        conflict = "diff --name-only --diff-filter=U";
        s = "status";
        d = "diff";
        a = "add";
        ds = "diff --staged";
        hist = ''
          log --pretty=format:"%h %ad - %ar | %s%d [%an]" --graph
          --date=short'';
        last = "log -1 HEAD";
        today = ''
          log --since=12am --pretty=format:"%h %ad - %ar | %s%d [%an]"
          --graph --date=short'';
        graph =
          "log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset'";
      };
    };

  };
}
