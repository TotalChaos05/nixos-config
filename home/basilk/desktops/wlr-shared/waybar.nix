{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });
    settings = {
      mainBar = {
        "layer" = "top"; # Waybar at top layer
        "position" = "top"; # Waybar position (top|bottom|left|right)
        # "height" = 5; # Waybar height (to be removed for auto height)
        # "width" = 1280; # Waybar width
        "spacing" = 4; # Gaps between modules (4px)
        # Choose the order of the modules
        "modules-left" = ["custom/home" "wlr/workspaces" "sway/mode" "sway/scratchpad"]; #"custom/media"];
        
        "modules-center" = ["wlr/taskbar"];
        "modules-right" = ["mpris" "idle_inhibitor" "pulseaudio" "network" "cpu" "memory" "temperature" "backlight" "battery" "battery#bat2" "clock" "tray"];
        # Modules configuration
        # "sway/workspaces" = {
        #     "disable-scroll" = true;
        #     "all-outputs" = true;
        #     "format" = "{name} = {icon}";
        #     "format-icons" = {
        #         "1" = "";
        #         "2" = "";
        #         "3" = "";
        #         "4" = "";
        #         "5" = "";
        #         "urgent" = "";
        #         "focused" = "";
        #         "default" = ""
        #     }
        # };
        "keyboard-state" = {
          "numlock" = true;
          "capslock" = true;
          "format" = "{name} {icon}";
          "format-icons" = {
            "locked" = "";
            "unlocked" = "";
          };
        };
        "sway/mode" = {
          "format" = "<span style=\"italic\">{}</span>";
        };
        "sway/scratchpad" = {
          "format" = "{icon} {count}";
          "show-empty" = false;
          "format-icons" = ["" ""];
          "tooltip" = true;
          "tooltip-format" = "{app} = {title}";
        };
        #    "mpd" = {
        #        "format" = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
        #        "format-disconnected" = "Disconnected ";
        #        "format-stopped" = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
        #        "unknown-tag" = "N/A";
        #        "interval" = 2;
        #        "consume-icons" = {
        #            "on" = " ";
        #        };
        #        "random-icons" = {
        #            "off" = "<span color=\"#f53c3c\"></span> ";
        #            "on" = " ";
        #        };
        #        "repeat-icons" = {
        #            "on" = " ";
        #        };
        #        "single-icons" = {
        #            "on" = "1 ";
        #        };
        #        "state-icons" = {
        #            "paused" = "";
        #            "playing" = "";
        #        };
        #        "tooltip-format" = "MPD (connected)";
        #        "tooltip-format-disconnected" = "MPD (disconnected)";
        #    };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        "tray" = {
          # "icon-size" = 21;
          "spacing" = 10;
        };
        "clock" = {
          "format" = "{:%I:%M %p}";
          # "timezone" = "America/New_York";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
        };
        "cpu" = {
          "format" = "{usage}% ";
          "tooltip" = false;
        };
        "memory" = {
          "format" = "{}% ";
        };
        "temperature" = {
          # "thermal-zone" = 2;
          # "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
          "critical-threshold" = 80;
          # "format-critical" = "{temperatureC}°C {icon}";
          "format" = "{temperatureC}°C {icon}";
          "format-icons" = ["" "" ""];
        };
        "backlight" = {
          # "device" = "acpi_video1";
          "format" = "{percent}% {icon}";
          "format-icons" = ["" "" "" "" "" "" "" "" ""];
        };
        "battery" = {
          "states" = {
            # "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          "format-alt" = "{time} {icon}";
          # "format-good" = ""; # An empty format will hide the module
          # "format-full" = "";
          "format-icons" = ["" "" "" "" ""];
        };
        "battery#bat2" = {
          "bat" = "BAT2";
        };
        "network" = {
          # "interface" = "wlp2*"; # (Optional) To force the use of this interface
#          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-wifi" = "({signalStrength}%) ";
          "format-ethernet" = "{ipaddr}/{cidr} ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = "Disconnected ⚠";
          "format-alt" = "{ifname} = {ipaddr}/{cidr}";
        };
        "pulseaudio" = {
          # "scroll-step" = 1; # %, can be a float
#          "format" = "{volume}% {icon} {format_source}";
          "format" = "{volume}% {icon}";
          "format-bluetooth" = "{volume}% {icon} {format_source}";
          "format-bluetooth-muted" = " {icon} {format_source}";
          "format-muted" = " {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" ""];
          };
          "on-click" = "pavucontrol";
        };
        #    "custom/media" = {
        #        "format" = "{icon} {}";
        #        "return-type" = "json";
        #        "max-length" = 40;
        #        "format-icons" = {
        #            "spotify" = "";
        #            "default" = "🎜";
        #        };
        #        "escape" = true;
        #        #"exec" = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
        #        # "exec" = "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null"; # Filter player based on name
        #    };
        "mpris" = {
          "dynamic-len" = 20;
          "format" = /*"{status_icon}*/" {dynamic}";
          "status-icons" = {
            "playing" = "⏵︎"; 
            "paused" = "⏸︎"; 
            "stopped" = "⏹︎";
            };
        };
        "wlr/taskbar"= {
          "format"= "{icon}";
          "icon-size"= 14;
          "icon-theme"= "Numix-Circle";
          "tooltip-format"= "{title}";
          "on-click"= "activate";
          "on-click-middle"= "close";
          "ignore-list"= [
           "Alacritty"
          ];
          "app_ids-mapping"= {
            "firefoxdeveloperedition"= "firefox-developer-edition";
          };
          "rewrite"= {
            "Firefox Web Browser"= "Firefox";
            "Foot Server"= "Terminal";
          };
        };
        "custom/home" = {
      	  "format" = "+";
	        "on-click" = "nwggrid -client";
        };
      };
    };
    style =  ''
    
      * {
        font-size: 12px;
        }
        /* Each module */
#battery,
#clock,
#cpu,
#language,
#memory,
#mode,
#network,
#pulseaudio,
#temperature,
#tray,
#backlight,
#idle_inhibitor,
#disk,
#user,
#mpris {
	padding-left: 8pt;
	padding-right: 8pt;
}
#custom-home {
	padding-left: 8pt;
	padding-right: 8pt;
}
    '';
  };
}
