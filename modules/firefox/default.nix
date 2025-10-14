{ pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.hippoid = {
      search.engines = {
        "arch wiki" = {
          ar = "https://wiki.archlinux.org/index.php?search={}";
          urls = [{
            template = "https://wiki.archlinux.org/index.php";
            params = [
              {
                name = "search";
                value = "{searchTerms}";
              }
            ];
          }];
          definedAliases = [ "ar" ];
        };

        "amazon" = {
          urls = [{
            template = "https://www.amazon.com/s";
            params = [
              {
                name = "k";
                value = "{searchTerms}";
              }
            ];
          }];
          definedAliases = [ "am" ];
        };

        "amazon books" = {
          urls = [{
            template = "https://www.amazon.com/s";
            params = [
              {
                name = "k";
                value = "{searchTerms}";
              }
              {
                name = "i";
                value = "stripbooks";
              }
            ];
          }];
          definedAliases = [ "amz" ];
        };

        "nixvim" = {
          urls = [{
            template = "https://nix-community.github.io/nixvim/";
            params = [
              {
                name = "search";
                value = "{searchTerms}";
              }
            ];
          }];
          definedAliases = [ "nv" ];
        };

        "Nix Options" = {
          urls = [{
            template = "https://search.nixos.org/options";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "no" ];
        };

        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "np" ];
        };

        "Chicago Public Library" = {
          urls = [{
            template = "https://chipublib.bibliocommons.com/v2/search";
            params = [
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }];

          definedAliases = [ "cpl" ];
        };

        "youtube" = {
          urls = [{
            template = "https://www.youtube.com/results";
            params = [
              {
                name = "search_query";
                value = "{searchTerms}";
              }
            ];
          }];

          definedAliases = [ "yt" ];
        };

        "loogle" = {
          urls = [{
            template = "https://loogle.lean-lang.org";
            params = [
              {
                name = "q";
                value = "{searchTerms}";
              }
            ];
          }];

          definedAliases = [ "lo" ];
        };

        "hoogle" = {
          urls = [{
            template = "https://hoogle.haskell.org";
            params = [
              {
                name = "hoogle";
                value = "{searchTerms}";
              }
            ];
          }];

          definedAliases = [ "ho" ];
        };

        "home-manager" = {
          urls = [{
            template = "https://home-manager-options.extranix.com";
            params = [
              {
                name = "query";
                value = "{searchTerms}";
              }

              {
                name = "release";
                value = "master";
              }
            ];
          }];

          definedAliases = [ "hm" ];
        };
      };

      search.force = true;
      settings = {
        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "identity.fxaccounts.enabled" = false;
        "signon.rememberSignons" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "browser.ping-centre.telemetry" = false;

        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.showTopSites" = false;
        "browser.newtabpage.activity-stream.showSearch" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";

        # Optional: make it a blank page
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.startup.page" = 3;
      };

      userChrome = ''
      '';

      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        sponsorblock
        darkreader
        tridactyl
        youtube-shorts-block
      ];
    };
  };
}
