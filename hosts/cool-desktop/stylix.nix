{ config, pkgs, lib, inputs, ... }: {
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
  # stylix.targets.console.enable = false;
  stylix.image = ../../assets/wallpaper.png;
  #stylix.targets.gdm.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${inputs.base16-schemes}/rose-pine.yaml";
  stylix.autoEnable = true;
}
