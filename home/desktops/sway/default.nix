  {
    imports = [../wlroots-shared];
  wayland.windowManager.sway = {
  enable = true;
  config = rec {
    modifier = "Mod4";
    terminal="foot";
    left="h";
    right="l";
    up="k";
    down="j";
    menu = "rofi -show combi -combi-modes drun#run - modes combi";
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
      {command = "waybar";
      position = "top";}
      ];
    };
  };
  }