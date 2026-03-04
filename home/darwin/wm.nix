{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.jankyborders ];

  xdg.configFile."borders/bordersrc" = {
    executable = true;
    text = ''
      #!/bin/bash
      options=(
        style=round
        width=6.0
        hidpi=off
        active_color=0xc0e2e2e3
        inactive_color=0xc02c2e34
        background_color=0x302c2e34
      )
      borders "''${options[@]}"
    '';
  };

  xdg.configFile."yabai/yabairc" = {
    executable = true;
    text = ''
      #!/usr/bin/env sh

      sudo yabai --load-sa
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

      yabai -m config mouse_follows_focus        off            \
                      focus_follows_mouse        on             \
                      window_zoom_persist        off            \
                      window_placement           second_child   \
                      window_shadow              float          \
                      window_opacity             on             \
                      window_opacity_duration    0.2            \
                      active_window_opacity      1.0            \
                      normal_window_opacity      1.0            \
                      window_animation_duration  0.5            \
                      window_animation_easing    ease_out_quint \
                      insert_feedback_color      0xff9dd274     \
                      split_ratio                0.50           \
                      auto_balance               off            \
                      mouse_modifier             fn             \
                      mouse_action1              move           \
                      mouse_action2              resize         \
                      mouse_drop_action          swap           \
                                                                \
                      top_padding                8              \
                      bottom_padding             8              \
                      left_padding               8              \
                      right_padding              8              \
                      window_gap                 8

      yabai -m rule --add app="^System Settings$"    manage=off
      yabai -m rule --add app="^System Preferences$" manage=off
      yabai -m rule --add app="^Activity Monitor$"   manage=off
      yabai -m rule --add app="^Finder$"             manage=off
      yabai -m rule --add app="^Messages$"           manage=off
      yabai -m rule --add app="^Firefox$" title="Library" manage=off
      yabai -m rule --add app="^Calendar$"           manage=off
      yabai -m rule --add app="^iPhone Mirroring$"   manage=off

      yabai -m config layout bsp

      echo "yabai configuration loaded.."
    '';
  };

  xdg.configFile."skhd/skhdrc".text = ''
    # Navigation
    alt - j : yabai -m window --focus north
    alt - k : yabai -m window --focus south
    alt - h : yabai -m window --focus west
    alt - l : yabai -m window --focus east

    # Window Movement
    shift + alt - j : yabai -m window --move north
    shift + alt - k : yabai -m window --move south
    shift + alt - h : yabai -m window --move west
    shift + alt - l : yabai -m window --move east

    shift + alt - r : yabai -m window --rotate 90
    shift + alt - y : yabai -m window --mirror y-axis
    shift + alt - x : yabai -m window --mirror x-axis
    shift + alt - f : yabai -m window --toggle float

    # Window Resize
    ctrl + alt - j : yabai -m window --resize top:10
    ctrl + alt - k : yabai -m window --resize bottom:10
    ctrl + alt - h : yabai -m window --resize left:10
    ctrl + alt - l : yabai -m window --resize right:10

    # Open Applications
    alt - return : open -a Kitty
    alt - b : open -a Firefox

    # Window Management
    alt - q : yabai -m window --close
    alt - f : yabai -m window --toggle zoom-fullscreen
    alt - t : yabai -m window --toggle float
  '';
}

