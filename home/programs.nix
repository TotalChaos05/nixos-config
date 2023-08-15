{pkgs, lib, inputs, ...}:
{
  programs.fzf = {
    enable = true;
  };
  programs.qutebrowser.enable = true;
  programs.bat.enable = true;
  programs.foot.enable = true;

  programs.rbw = {
    enable = true;
  };
  # programs.starship.enable = true;
  programs.helix.enable = true;
  programs.helix.package = inputs.helix.packages.x86_64-linux.helix;
  programs.helix.settings = {
    editor.cursor-shape = {
      insert = "bar";
      normal = "block";
      select = "underline";
    };
  };
  programs.imv.enable = true;
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird;
    profiles = {};
  };
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
  programs.fish = {
    enable = true;
    interactiveShellInit = "printf '\\033[0;32muse Ctrl+Alt+F for file finder !\\033[0m\\n'";
    plugins = 
    [
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "v9.9";
          sha256 = "Aqr6+DcOS3U1R8o9Mlbxszo5/Dy9viU4KbmRGXo95R8=";
        };
      }
      {
        name = "autopair.fish";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "1.0.4";
          sha256 = "s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU=";
        };
      }
      {
        name = "tide";
        src = pkgs.fetchFromGitHub {
          owner = "IlanCosman";
          repo = "tide";
          rev = "v5.6.0";
          sha256 = "cCI1FDpvajt1vVPUd/WvsjX/6BJm6X1yFPjqohmo1rI=";
        };
      }
    ];
  };
/*
    programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "master";
          sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
    ];
    prezto = {
      enable = true;
    };
  };
*/
}
