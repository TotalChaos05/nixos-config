{pkgs, lib, ...}:
{
    programs.foot.enable = true;
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
  programs.swaylock = {
    enable = true;
    settings = {
      image = lib.mkDefault "~/wallpaper.png";
      scaling = "fill";
    };
  };
  programs.rbw = {
    enable = true;
  };
  programs.starship.enable = true;
  programs.helix.enable = true;
  programs.imv.enable = true;
  #programs.thunderbird = {
  #  enable = true;
  #  package = pkgs.betterbird;
  #  profiles = {};
  #};
  programs.ncmpcpp = {
    enable = true;
    settings = {
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_in_stereo = "yes";
      media_library_primary_tag = "album_artist";
    };
  };
  programs.mpv.enable = true;
  programs.yt-dlp.enable = true;
}
