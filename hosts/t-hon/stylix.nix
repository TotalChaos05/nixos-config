{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
  stylix.image = ./assets/wallpaper.png;
  stylix.targets.console.enable = true;
  stylix.targets.grub.enable = true;
  #stylix.targets.gdm.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.base16Scheme = "${inputs.base16-schemes}/catppuccin-macchiato.yaml";
  stylix.autoEnable = true;
}
