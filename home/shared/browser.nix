{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "always";
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      HttpsOnlyMode = "force_enabled";
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;

      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
      };

      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };

      SearchSuggestEnabled = false;

      # Extensions
      ExtensionSettings = {
        "*".installation_mode = "blocked";

        # Allow Right-Click
        "{278b0ae0-da9d-4cc6-be81-5aa7f3202672}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/{278b0ae0-da9d-4cc6-be81-5aa7f3202672}/latest.xpi";
          installation_mode = "force_installed";
        };
        # Decentraleyes
        "jid1-BoFifL9Vbdl2zQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi";
          installation_mode = "force_installed";
        };
        # DuckDuckGo Privacy Essentials
        "jid1-ZAdIEUB7XOzOJw@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
          installation_mode = "force_installed";
        };
        # Search by Image
        "{2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/search_by_image/latest.xpi";
          installation_mode = "force_installed";
        };
        # Stylus
        "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi";
          installation_mode = "force_installed";
        };
        # To Google Translate
        "jid1-93WyvpgvxzGATw@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/to-google-translate/latest.xpi";
          installation_mode = "force_installed";
        };
        # Skip Redirect
        "skipredirect@sblask" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/skip-redirect/latest.xpi";
          installation_mode = "force_installed";
        };
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Violentmonkey
        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
          installation_mode = "force_installed";
        };
        # WannabeOxocarbon theme
        "{00301bef-5de5-4fff-9f7f-ae3ac99c632f}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/{00301bef-5de5-4fff-9f7f-ae3ac99c632f}/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles."user" = {
      id = 0;
      isDefault = true;

      settings = {
        # New tabs
        "browser.startup.page" = 0;
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;

        # Vertic Tabs
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;

        # Containers
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;

        # Passwords and autofill
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
        "signon.formlessCapture.enabled" = false;
        "signon.management.page.breach-alerts.enabled" = false;
        "signon.firefoxRelay.showToAllBrowsers" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "browser.formfill.enable" = false;
        "network.auth.subresource-http-auth-allow" = 1;
        "editor.truncate_user_pastes" = false;

        # AI/ML
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.menu" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.ml.pageAssist.enabled" = false;
        "browser.ml.smartAssist.enabled" = false;
        "extensions.ml.enabled" = false;
        "browser.tabs.groups.smart.enabled" = false;
        "browser.search.visualSearch.featureGate" = false;
        "browser.urlbar.quicksuggest.mlEnabled" = false;
        "pdfjs.enableAltText" = false;
        "places.semanticHistory.featureGate" = false;
        "browser.ai.control.default" = "blocked";
        "browser.ai.control.linkPreviewKeyPoints" = "blocked";
        "browser.ai.control.pdfjsAltText" = "blocked";
        "browser.ai.control.sidebarChatbot" = "blocked";
        "browser.ai.control.smartTabGroups" = "blocked";
        "browser.ai.control.translations" = "blocked";

        # Fastfox
        "content.notify.interval" = 100000;
        "gfx.canvas.accelerated.cache-size" = 512;
        "gfx.content.skia-font-cache-size" = 20;
        "browser.cache.disk.enable" = false;
        "browser.sessionhistory.max_total_viewers" = 4;
        "media.memory_cache_max_size" = 65536;
        "media.cache_readahead_limit" = 7200;
        "media.cache_resume_threshold" = 3600;
        "image.mem.decode_bytes_at_a_time" = 32768;
        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.max-urgent-start-excessive-connections-per-host" = 5;
        "network.http.pacing.requests.enabled" = false;
        "network.dnsCacheExpiration" = 3600;
        "network.ssl_tokens_cache_capacity" = 10240;
        "layout.css.grid-template-masonry-value.enabled" = true;

        # Speculative loading
        "network.http.speculative-parallel-limit" = 0;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.places.speculativeConnect.enabled" = false;
        "network.prefetch-next" = false;
        "network.predictor.enabled" = false;

        # Securefox
        "browser.contentblocking.category" = "strict";
        "privacy.trackingprotection.allow_list.baseline.enabled" = true;
        "privacy.trackingprotection.allow_list.convenience.enabled" = true;
        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.uitour.enabled" = false;
        "privacy.globalprivacycontrol.enabled" = true;
        "security.OCSP.enabled" = 0;
        "security.pki.crlite_mode" = 2;
        "security.csp.reporting.enabled" = false;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "security.tls.enable_0rtt_data" = false;
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.sessionstore.interval" = 60000;
        "browser.privatebrowsing.resetPBM.enabled" = true;
        "privacy.history.custom" = true;
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
        "browser.search.separatePrivateDefault.ui.enabled" = true;
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "network.IDN_show_punycode" = true;
        "signon.privateBrowsingCapture.enabled" = false;
        "security.mixed_content.block_display_content" = true;
        "pdfjs.enableScripting" = false;
        "extensions.enabledScopes" = 5;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "permissions.default.desktop-notification" = 2;
        "permissions.default.geo" = 2;
        "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";
        "browser.search.update" = false;
        "permissions.manager.defaultsUrl" = "";
        "extensions.getAddons.cache.enabled" = false;

        # Telemetry
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "datareporting.usage.uploadEnabled" = false;

        # Peskyfox
        "browser.privatebrowsing.vpnpromourl" = "";
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.preferences.moreFromMozilla" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.profiles.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;  # enables userChrome.css
        "browser.compactmode.show" = true;
        "browser.privateWindowSeparation.enabled" = false;
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.warning.timeout" = 0;
        "browser.urlbar.trending.featureGate" = false;
        "extensions.pocket.enabled" = false;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.download.open_pdf_attachments_inline" = true;
        "browser.bookmarks.openInTabClosesMenu" = false;
        "browser.menu.showViewImageInfo" = true;
        "findbar.highlightAll" = true;
        "layout.word_select.eat_space_to_next_word" = false;
        "browser.search.suggest.enabled.private" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.topsites.contile.enabled" = false;

        # Overrides
        "identity.fxaccounts.enabled" = false;
        "browser.firefox-view.feature-tour" = "{\"screen\":\"\",\"complete\":true}";
        "browser.link.open_newwindow.override.external" = 7;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.recentsearches" = false;
      };

      search = {
        default = "ddg";
        privateDefault = "ddg";
        force = true;
      };
    };
  };
}
