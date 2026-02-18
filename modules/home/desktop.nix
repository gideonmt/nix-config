{ config, pkgs, lib, ... }:

let
  c = import ./colors.nix;

  wkBase = {
    font = "JetBrainsMono Nerd Font 12";
    background = "#${lib.removePrefix "#" c.bg}ee";
    color = "#${lib.removePrefix "#" c.fg}";
    border = "#${lib.removePrefix "#" c.pink}";
    separator = "  ";
    border_width = 1;
    corner_r = 8;
    padding = 15;
    anchor = "center";
    inhibit_compositor_keyboard_shortcuts = true;
  };

  mkMenu = extra: lib.generators.toYAML {} (wkBase // extra);

  wk = name: "${lib.getExe pkgs.wlr-which-key} ${name}";

  spawnApps      = "${lib.getExe pkgs.wlr-which-key} apps";
  spawnResizeH   = "${lib.getExe pkgs.wlr-which-key} resize-h";
  spawnResizeV   = "${lib.getExe pkgs.wlr-which-key} resize-v";
  spawnScreenshot = "${lib.getExe pkgs.wlr-which-key} screenshot";
in
{
  xdg.configFile = {
    "wlr-which-key/apps.yaml".text = mkMenu {
      menu = [
        { key = "b"; desc = "Firefox";  cmd = "firefox"; }
        { key = "k"; desc = "Kitty";    cmd = "kitty"; }
        { key = "v"; desc = "Vesktop";  cmd = "vesktop"; }
      ];
    };

    "wlr-which-key/resize-h.yaml".text = mkMenu {
      menu = [
        { key = "1"; desc = "1/4"; cmd = "niri msg action set-column-width 25%"; }
        { key = "2"; desc = "1/3"; cmd = "niri msg action set-column-width 33.333%"; }
        { key = "3"; desc = "1/2"; cmd = "niri msg action set-column-width 50%"; }
        { key = "4"; desc = "2/3"; cmd = "niri msg action set-column-width 66.667%"; }
        { key = "5"; desc = "3/4"; cmd = "niri msg action set-column-width 75%"; }
        { key = "f"; desc = "Full"; cmd = "niri msg action maximize-column"; }
        { key = "a"; desc = "Available width"; cmd = "niri msg action expand-column-to-available-width"; }
      ];
    };

    "wlr-which-key/resize-v.yaml".text = mkMenu {
      menu = [
        { key = "1"; desc = "1/4"; cmd = "niri msg action set-window-height 25%"; }
        { key = "2"; desc = "1/3"; cmd = "niri msg action set-window-height 33.333%"; }
        { key = "3"; desc = "1/2"; cmd = "niri msg action set-window-height 50%"; }
        { key = "4"; desc = "2/3"; cmd = "niri msg action set-window-height 66.667%"; }
        { key = "5"; desc = "3/4"; cmd = "niri msg action set-window-height 75%"; }
        { key = "r"; desc = "Reset"; cmd = "niri msg action reset-window-height"; }
      ];
    };

    "wlr-which-key/screenshot.yaml".text = mkMenu {
      menu = [
        { key = "s"; desc = "Select region";  cmd = "niri msg action screenshot"; }
        { key = "S"; desc = "Full screen";    cmd = "niri msg action screenshot-screen"; }
        { key = "w"; desc = "Window";         cmd = "niri msg action screenshot-window"; }
        { key = "r"; desc = "Record screen";  cmd = "wl-screenrec -f ~/Videos/recording-$(date +%Y-%m-%d_%H-%M-%S).mp4"; }
        { key = "R"; desc = "Stop recording"; cmd = "pkill wl-screenrec"; }
      ];
    };
  };

  # Cursor theme
  home.packages = [ pkgs.simp1e-cursors ];
  home.pointerCursor = {
    name    = "Simp1e-Dark";
    package = pkgs.simp1e-cursors;
    size    = 8;
  };

  # Niri
  xdg.configFile."niri/config.kdl".text = ''
    input {
        keyboard {
            xkb { }
        }
        touchpad {
            tap
            natural-scroll
        }
        mouse { }
    }

    layout {
        gaps 6
        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }
        default-column-width { proportion 0.5; }

        focus-ring {
            width 1
            active-color "${c.pink}"
            inactive-color "${c.base03}"
        }

        border {
            off
            width 4
            active-color "${c.green}"
            inactive-color "${c.bg-muted}"
            urgent-color "${c.pink}"
        }

        shadow {
            softness 20
            spread 2
            offset x=0 y=3
            color "${c.bg}44"
        }
    }

    spawn-at-startup "waybar"
    spawn-at-startup "wl-paste" "--type" "text" "--watch" "cliphist" "store"
    spawn-at-startup "wl-paste" "--type" "image" "--watch" "cliphist" "store"
    
    hotkey-overlay {
        skip-at-startup
    }

    prefer-no-csd

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    animations {
        slowdown 1.0
    }

    // Rounded corners for all windows
    window-rule {
        geometry-corner-radius 8
        clip-to-geometry true
    }

    // Kitty
    window-rule {
        match app-id=r#"^kitty$"#
        default-column-width {}
    }

    // Firefox PiP
    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        open-floating true
    }

    binds {
	// Fuzzel binds
        Mod+Space   hotkey-overlay-title="Launcher: fuzzel" { spawn "fuzzel"; }
        Mod+D       hotkey-overlay-title="Apps"             { spawn-sh "${spawnApps}"; }

        Super+Alt+S allow-when-locked=true hotkey-overlay-title=null { spawn-sh "pkill orca || exec orca"; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
        XF86AudioMute        allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }

        XF86AudioPlay allow-when-locked=true { spawn-sh "playerctl play-pause"; }
        XF86AudioStop allow-when-locked=true { spawn-sh "playerctl stop"; }
        XF86AudioPrev allow-when-locked=true { spawn-sh "playerctl previous"; }
        XF86AudioNext allow-when-locked=true { spawn-sh "playerctl next"; }

        XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }
        XF86KbdBrightnessUp   allow-when-locked=true { spawn "brightnessctl" "-d" "kbd_backlight" "set" "+10%"; }
        XF86KbdBrightnessDown allow-when-locked=true { spawn "brightnessctl" "-d" "kbd_backlight" "set" "10%-"; }

        Mod+O repeat=false { toggle-overview; }
        Mod+Q repeat=false { close-window; }

        Mod+H { focus-column-left; }
        Mod+J { focus-window-or-workspace-down; }
        Mod+K { focus-window-or-workspace-up; }
        Mod+L { focus-column-right; }
        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }

        Mod+Shift+H { move-column-left; }
        Mod+Shift+J { move-window-down-or-to-workspace-down; }
        Mod+Shift+K { move-window-up-or-to-workspace-up; }
        Mod+Shift+L { move-column-right; }
        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Down  { move-window-down; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Right { move-column-right; }

        Mod+Ctrl+Left  { focus-monitor-left; }
        Mod+Ctrl+Down  { focus-monitor-down; }
        Mod+Ctrl+Up    { focus-monitor-up; }
        Mod+Ctrl+Right { focus-monitor-right; }

        Mod+Shift+Ctrl+H { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+J { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+K { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+L { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }

        Mod+U       { focus-workspace-down; }
        Mod+I       { focus-workspace-up; }
        Mod+Shift+U { move-column-to-workspace-down; }
        Mod+Shift+I { move-column-to-workspace-up; }
        Mod+Ctrl+Shift+U { move-workspace-down; }
        Mod+Ctrl+Shift+I { move-workspace-up; }

        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }
        Mod+WheelScrollRight      { focus-column-right; }
        Mod+WheelScrollLeft       { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft  { move-column-left; }
        Mod+Shift+WheelScrollDown      { focus-column-right; }
        Mod+Shift+WheelScrollUp        { focus-column-left; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }
        Mod+Comma        { consume-window-into-column; }
        Mod+Period       { expel-window-from-column; }

        Mod+R hotkey-overlay-title="Column width"      { spawn-sh "${spawnResizeH}"; }
        Mod+Shift+R hotkey-overlay-title="Row height"  { spawn-sh "${spawnResizeV}"; }
        Mod+F hotkey-overlay-title="Fullscreen Window" { fullscreen-window; }

        Mod+C       { center-column; }
        Mod+Ctrl+C  { center-visible-columns; }

        Mod+Minus       { set-column-width "-10%"; }
        Mod+Equal       { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Mod+V       { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }
        Mod+W       { toggle-column-tabbed-display; }

        Mod+S hotkey-overlay-title="Screenshot" { spawn-sh "${spawnScreenshot}"; }

        Mod+Shift+E { quit; }
    }
  '';

  # Waybar
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer   = "top";
        position = "top";
        height  = 24;
        spacing = 0;
        margin-top   = 6;
        margin-left  = 6;
        margin-right = 6;

        modules-left   = [ "niri/workspaces" "niri/window" ];
        modules-center = [ ];
        modules-right  = [
          "pulseaudio"
          "backlight"
          "battery"
          "network"
          "clock"
          "tray"
        ];

        "niri/workspaces" = {
          format = "{index}";
        };

        "niri/window" = {
          max-length = 50;
        };

        clock = {
          format         = "{:%a %b %d %I:%M:%S %p}";
          tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
          timezone       = "America/New_York";
          interval       = 1;
        };

        pulseaudio = {
          format       = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = { default = [ "󰕿" "󰖀" "󰕾" ]; };
          on-click     = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          scroll-step  = 5;
        };

        backlight = {
          device       = "apple-panel-bl";
          format       = "{icon} {percent}%";
          format-icons = [ "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" ];
        };

        battery = {
          states           = { warning = 30; critical = 15; };
          format           = "{icon} {capacity}%";
          format-charging  = "󰂄 {capacity}%";
          format-plugged   = "󰚥 {capacity}%";
          format-icons     = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        network = {
          format-wifi         = "󰤨 {essid}";
          format-ethernet     = "󰈀 {ifname}";
          format-disconnected = "󰤭";
	  tooltip-format      = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
	  tooltip-format-disconnected = "Disconnected";
        };

        tray = {
          spacing = 6;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 12px;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: ${c.fg};
      }

      .modules-left,
      .modules-right {
        background: ${c.bg};
        border-radius: 8px;
        padding: 2px;
      }

      #workspaces {
        padding: 0 2px;
      }

      #workspaces button {
        padding: 0 6px;
        color: ${c.fg};
        background: transparent;
        border-radius: 6px;
        margin: 2px 1px;
        min-width: 0;
      }
      #workspaces button.active {
        color: ${c.bg};
        background: ${c.pink};
      }
      #workspaces button.urgent {
        color: ${c.bg};
        background: ${c.magenta};
      }
      #workspaces button:hover {
        color: ${c.fg};
        background: ${c.bg-muted};
	border: none;
      }

      #window {
        color: ${c.accent2};
        padding: 0 4px;
      }

      window#waybar.empty #window {
        padding: 0;
      }

      #pulseaudio,
      #backlight,
      #battery,
      #network,
      #clock,
      #tray {
        padding: 0 8px;
        color: ${c.fg};
      }

      #pulseaudio,
      #backlight,
      #battery,
      #network {
        border-right: 1px solid ${c.bg-muted};
      }

      #clock {
        color: ${c.fg-bright};
      }

      #pulseaudio.muted { color: ${c.bg-muted}; }
      #battery.warning  { color: ${c.lavender}; }
      #battery.critical { color: ${c.magenta};  }
      #battery.charging { color: ${c.green};    }
    '';
  };

  # Fuzzel
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font              = "JetBrains Mono:size=12";
        terminal          = "kitty";
        layer             = "overlay";
        width             = 30;
        lines             = 10;
        horizontal-pad    = 20;
        vertical-pad      = 8;
        inner-pad         = 4;
        image-size-ratio  = 1;
      };

      colors = {
        # Format: rrggbbaa
        background        = "${lib.removePrefix "#" c.bg}ee";
        text              = "${lib.removePrefix "#" c.fg}ff";
        match             = "${lib.removePrefix "#" c.pink}ff";
        selection         = "${lib.removePrefix "#" c.bg-muted}ff";
        selection-text    = "${lib.removePrefix "#" c.fg-bright}ff";
        selection-match   = "${lib.removePrefix "#" c.pink}ff";
        border            = "${lib.removePrefix "#" c.pink}ff";
      };

      border = {
        width  = 1;
        radius = 8;
      };
    };
  };
}
