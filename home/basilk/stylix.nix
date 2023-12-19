{
  config,
  pkgs,
  lib,
  ...
}: 
let 
  opacity = 1.0; 
in {
  stylix.targets.swaylock.enable = true;
  #programs.swaylock = {
  #  enable = true;
  #  settings = {
  #    image = lib.mkDefault "~/wallpaper.png";
  #    scaling = "fill";
  #  };
  #};

  #stylix.targets.console.enable = true;
  #stylix.targets.grub.enable = true;
  #stylix.targets.gtk.enable = true;
  #stylix.targets.foot.enable = true;
  # Stylix targets
  #stylix.targets.gnome.enable = true;
  #stylix.targets.gtk.enable = true;
  #stylix.targets.kde.enable = true;
  #stylix.targets.foot.enable = true;
  #stylix.targets.waybar.enable = true;
  #stylix.targets.rofi.enable = true;
  #stylix.targets.mako.enable = true;
  #stylix.autoEnable = true;
  #stylix.polarity = "dark";
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
  stylix.targets.kitty.enable = true;
    
  stylix.opacity = {
    applications = opacity;
    desktop = opacity;
    popups = opacity;
    terminal = opacity;
  };
  
  #stylix.image = ./wallpaper.png;
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  #stylix.autoEnable = true;
    stylix.fonts = {
    serif = {
      package = pkgs.noto-fonts;
      name = "Noto Serif";
    };

    sansSerif = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
    };

    monospace = {
      package = pkgs.noto-fonts;
      name = "Noto Sans Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
  stylix.image = ../../assets/wallpaper.png;
  #stylix.targets.gdm.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  stylix.autoEnable = true;
  stylix.cursor = {
    name = "Adwaita";
    size = 24;
  };
}
