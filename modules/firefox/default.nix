{ pkgs, inputs, config, ... }:

let
  addonId = "urlq@idrisraja.com";
  firefoxAppId = "{ec8030f7-c20a-464f-9b0e-13a3a9e97384}";
  urlqExtension = pkgs.stdenvNoCC.mkDerivation {
    pname = "urlq-capture";
    version = "0.1.0";
    src = ./2c0afd48075644e7b308-0.1.0.xpi;
    dontUnpack = true;
    installPhase = ''
      install -Dm444 "$src" \
        "$out/share/mozilla/extensions/${firefoxAppId}/${addonId}.xpi"
    '';

    passthru = {
      inherit addonId;
    };
  };

in
{


  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
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

        "arxiv" = {
          urls = [{
            template = "https://arxiv.org/search/";
            params = [
              {
                name = "query";
                value = "{searchTerms}";
              }
              {
                name = "searchtype";
                value = "title";
              }
            ];
          }];
          definedAliases = [ "ax" ];
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

        "mdn" = {
          urls = [{
            template = "https://developer.mozilla.org/en-US/search";
            params = [
              {
                name = "q";
                value = "{searchTerms}";
              }
            ];
          }];
          definedAliases = [ "mdn" ];
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


        "numpy" = {
          urls = [{
            template = "https://numpy.org/doc/stable/search.html";
            params = [
              {
                name = "q";
                value = "{searchTerms}";
              }
            ];
          }];

          definedAliases = [ "nu" ];
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

        "noogle" = {
          urls = [{
            template = "https://noogle.dev/q";
            params = [
              {
                name = "term";
                value = "{searchTerms}";
              }
            ];
          }];
          definedAliases = [ "nl" ];
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


      extensions.packages =
        let
          system = pkgs.stdenv.hostPlatform.system;
          addonsForSystem = inputs.firefox-addons.packages.${system} or null;
        in
        if addonsForSystem == null then [ ] else with addonsForSystem; [
          # ublock-origin
          darkreader
          sponsorblock
          urlqExtension
          youtube-shorts-block
        ];
    };
  };
}
