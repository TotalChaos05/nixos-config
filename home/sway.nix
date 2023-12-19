{pkgs, lib, inputs, ...}:
{
  imports = [./wlr-shared.nix ./waybar.nix];
  home.packages = [pkgs.autotiling];
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "sway";
  };
  programs.waybar.settings.mainBar."modules-left" = lib.mkForce ["sway/workspaces" "sway/mode" "sway/scratchpad"]; 
  wayland.windowManager.sway = {
    systemd.enable = true;
    enable = true;
    package = pkgs.swayfx;
    config = rec {
      modifier = "Mod4";
      terminal = "foot";
      menu = "rofi -show combi -combi-modes drun#run - modes combi";
      focus.mouseWarping = true;
      input = {
        "type:touchpad" = {
          click_method = "clickfinger";
          tap = "enabled";
          natural_scroll = "enabled";
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
      default_border pixel 1
      default_floating_border normal
      # hide_edge_borders smart
      # smart_gaps on
      set $mod Mod4
      exec_always swaybg ~/.wallpaper.png
      exec_always autotiling 
      unbindsym $mod+shift+q
      corner_radius 5
      gaps inner 10
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
      bindsym Print exec flameshot gui
      bindsym $mod+q kill
      bindsym XF86MonBrightnessDown exec brightnessctl set 5%-
      bindsym XF86MonBrightnessUp exec brightnessctl set 5%+
      bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_SINK@ 5%+
      bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_SINK@ 5%-
      bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_SINK@ toggle
      bindsym XF86AudioMicMute exec wpctl set-mute @DEFAULT_SOURCE@ toggle
    '';
  };
}
