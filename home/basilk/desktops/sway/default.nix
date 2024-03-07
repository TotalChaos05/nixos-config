{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [../wlr-shared];
  home.packages = [pkgs.autotiling];
  home.sessionVariables = {
    # XDG_CURRENT_DESKTOP = "sway";
  };
  programs.waybar.settings.mainBar."modules-left" = lib.mkForce ["sway/workspaces" "sway/mode" "sway/scratchpad"];
  programs.waybar.settings.mainBar."modules-center" = lib.mkForce ["sway/window"];
  wayland.windowManager.sway = {
    systemd.enable = true;
    wrapperFeatures.gtk = true;
    systemdIntegration = true;
    enable = true;
    package = pkgs.swayfx;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      # menu = "rofi -show combi -combi-modes drun#run - modes combi";
      # menu = "onagre";
      menu = "fuzzel";
      focus.mouseWarping = true;
      input = {
        "type:touchpad" = {
          click_method = "clickfinger";
          tap = "enabled";
          natural_scroll = "enabled";
          dwt = "disabled";
          #pointer_accel 0.3
          #accel_profile adaptive
          middle_emulation = "enabled";
        };
      };
      bars = [
        {
          command = "waybar";
          position = "top";
        }
      ];
    };
    extraConfig = ''


      # for_window [title="^ncmpcpp*"] floating enable
      for_window [class="REAPER" instance="REAPER"] floating enable
      for_window [app_id="firefox" title="^Picture-in-Picture$"] border none, floating enable, sticky enable

      # for_window [class="REAPER" instance="REAPER" title="^REAPER v*"] fullscreen enable
      default_border pixel 1
      default_floating_border normal
      # hide_edge_borders smart
      # smart_gaps on
      set $mod Mod4
      exec_always swaybg ~/.wallpaper.png
      exec_always autotiling
      unbindsym $mod+shift+q
      corner_radius 5
      gaps inner 5
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
      bindsym Print exec grim -g "$(slurp)" - | wl-copy -t image/png
      bindsym $mod+shift+d exec kaokao --files ~/kaomoji.csv| wl-copy
      bindsym $mod+c sticky toggle
      bindsym $mod+q kill
      bindsym XF86MonBrightnessDown exec brightnessctl set 5%-
      bindsym XF86MonBrightnessUp exec brightnessctl set 5%+
      bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_SINK@ 5%+
      bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_SINK@ 5%-
      bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_SINK@ toggle
      bindsym XF86AudioMicMute exec wpctl set-mute @DEFAULT_SOURCE@ toggle


      exec_always rm -f /tmp/sovpipe && mkfifo /tmp/sovpipe && tail -f /tmp/sovpipe | sov -t 500

      bindsym --no-warn --no-repeat $mod+1 workspace number 1; exec "echo 1 > /tmp/sovpipe"
      bindsym --no-warn --no-repeat $mod+2 workspace number 2; exec "echo 1 > /tmp/sovpipe"
      bindsym --no-warn --no-repeat $mod+3 workspace number 3; exec "echo 1 > /tmp/sovpipe"
      bindsym --no-warn --no-repeat $mod+4 workspace number 4; exec "echo 1 > /tmp/sovpipe"
      bindsym --no-warn --no-repeat $mod+5 workspace number 5; exec "echo 1 > /tmp/sovpipe"
      bindsym --no-warn --no-repeat $mod+6 workspace number 6; exec "echo 1 > /tmp/sovpipe"
      bindsym --no-warn --no-repeat $mod+7 workspace number 7; exec "echo 1 > /tmp/sovpipe"
      bindsym --no-warn --no-repeat $mod+8 workspace number 8; exec "echo 1 > /tmp/sovpipe"
      bindsym --no-warn --no-repeat $mod+9 workspace number 9; exec "echo 1 > /tmp/sovpipe"
      bindsym --no-warn --no-repeat $mod+0 workspace number 10; exec "echo 1 > /tmp/sovpipe"
  
      bindsym --no-warn --release $mod+1 exec "echo 0 > /tmp/sovpipe"
      bindsym --no-warn --release $mod+2 exec "echo 0 > /tmp/sovpipe"
      bindsym --no-warn --release $mod+3 exec "echo 0 > /tmp/sovpipe"
      bindsym --no-warn --release $mod+4 exec "echo 0 > /tmp/sovpipe"
      bindsym --no-warn --release $mod+5 exec "echo 0 > /tmp/sovpipe"
      bindsym --no-warn --release $mod+6 exec "echo 0 > /tmp/sovpipe"
      bindsym --no-warn --release $mod+7 exec "echo 0 > /tmp/sovpipe"
      bindsym --no-warn --release $mod+8 exec "echo 0 > /tmp/sovpipe"
      bindsym --no-warn --release $mod+9 exec "echo 0 > /tmp/sovpipe"
      bindsym --no-warn --release $mod+0 exec "echo 0 > /tmp/sovpipe"
    '';
  };
}
