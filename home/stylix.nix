{
  config,
  pkgs,
  lib,
  ...
}: {
  #stylix.targets.swaylock.enable = true;
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
  #stylix.targets.foot.enable = true;
  #stylix.targets.waybar.enable = true;
  #stylix.targets.rofi.enable = true;
  #stylix.targets.mako.enable = true;
  #stylix.autoEnable = true;
  stylix.polarity = "dark";
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
  #stylix.opacity.terminal = 0.82;
  #stylix.image = ./wallpaper.png;
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  #stylix.autoEnable = true;
}
