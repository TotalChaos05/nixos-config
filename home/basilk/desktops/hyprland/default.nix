{
  pkgs,
  lib,
  hyprland-plugins,
  inputs,
  ...
}: {
  imports = [../wlr-shared];
  home.packages = [
    pkgs.libva
    # inputs.xdph.packages.x86_64-linux.xdg-desktop-portal-hyprland
  ];
  services.swayidle.systemdTarget = "hyprland-session.target";
  programs.waybar.settings = {
    mainBar = {
      "modules-center" = ["hyprland/window"];
      "modules-left" = ["hyprland/workspaces" "sway/mode" "sway/scratchpad"]; #"custom/media"];
    };
    "hyprland/workspaces" = {
      "format" = "{icon}";
      "on-scroll-up" = "hyprctl dispatch workspace e+1";
      "on-scroll-down" = "hyprctl dispatch workspace e-1";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.x86_64-linux.hyprland;
    #nvidiaPatches = true;
    systemdIntegration = true;
    xwayland = {
      enable = true;
    };

    plugins = [
      #hyprland-plugins.packages.x86_64-linux.hyprbars
    ];
    extraConfig = ''
       monitor = ,preferred,auto,1
      $terminal = foot
      exec-once = waybar
      exec-once = swaync
      exec-once = swaybg -i ~/.wallpaper.png
      source=~/.config/hypr/mocha.conf

      exec-once=export XDG_SESSION_TYPE=wayland
      exec-once=/nix/store/h3i7qlla1isix0vbw1j9d3v0a7qjrds4-dbus-1.14.0/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP
      exec-once=systemctl start --user swayidle
      # Example volume button that allows press and hold, volume limited to 150%
      bindle=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+


      bind=SUPER_SHIFT,S,movetoworkspace,special
      bind=SUPER,S,togglespecialworkspace,


      # Example volume button that will activate even while an input inhibitor is active
      bindle=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-


      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      env = XCURSOR_SIZE,12

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = true
      	tap-to-click = true
      	clickfinger_behavior = true
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 10
          border_size = 2
      #    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
      #    col.inactive_border = rgba(595959aa)
          col.active_border=$lavender
          col.inactive_border=$surface2

          layout = dwindle
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 6
          blur {
              enabled = true
              size = 3
              passes = 1
              new_optimizations = true
          }
          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = true

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = true
          workspace_swipe_forever = false

      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      device:epic-mouse-v1 {
          sensitivity = -0.5
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER
      $mod = SUPER
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

      bind = $mod, Return, exec,$terminal

      bind = $mod SHIFT, left, movewindow, l
      bind = $mod SHIFT, H, movewindow, l

      bind = $mod SHIFT, right, movewindow, r
      bind = $mod SHIFT, L, movewindow, r

      bind = $mod SHIFT, down, movewindow, d
      bind = $mod SHIFT, J, movewindow, d

      bind = $mod SHIFT, up, movewindow, u
      bind = $mod SHIFT, K, movewindow, u

      # NOTIFICATIONS
      bind = $mod SHIFT, N, exec, swaync-client -t -sw

      bind = $mod, E, togglegroup

      bind = $mod, space, togglefloating, active


      bind = $mod, F, fullscreen, 1

      bind = $mod, Q, killactive

      bind = $mod, D, exec, rofi -show drun

      bind = $mod SHIFT, E, exit

      # window resize
      bind = $mod, R, submap, resize

      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, H, movefocus, l

      bind = $mainMod, right, movefocus, r
      bind = $mainMod, L, movefocus, r

      bind = $mainMod, up, movefocus, u
      bind = $mainMod, K, movefocus, u

      bind = $mainMod, down, movefocus, d
      bind = $mainMod, J, movefocus, d


      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      exec systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
      #exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
      env = XDG_CURRENT_DESKTOP, sway

    '';
  };
}
