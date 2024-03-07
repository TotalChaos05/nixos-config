{pkgs, lib, inputs, ...}:
{
  programs = {
  fzf = {
    enable = true;
  };
  kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
    };
  };
  thefuck.enable = true;



vscode = {
  enable = true;
  package = pkgs.vscodium.fhsWithPackages (ps: with ps; [ rustup zlib ]);
};

  
  direnv.nix-direnv.enable = true;
  direnv.enable = true;
  #qutebrowser.enable = true;
  bat.enable = true;
  foot.enable = true;
  wlogout = {
    enable = true;
  };
  rbw = {
    enable = true;
  };
  # starship.enable = true;
  wezterm.enable = true;
  nnn = {
    enable = true;
    package = (pkgs.nnn.override { withNerdIcons = true; });
    plugins = {
      mappings = {
        p = "preview-tui";
      };
      src = (pkgs.fetchFromGitHub {
        owner = "jarun";
        repo = "nnn";
        rev = "v4.8";
        sha256 = "QbKW2wjhUNej3zoX18LdeUHqjNLYhEKyvPH2MXzp/iQ=";
      }) + "/plugins";
    };
  };
  
  helix = {
    enable = true;
    package = inputs.helix.packages.x86_64-linux.helix;
    settings = {
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      editor.auto-completion = true;
      editor.lsp = {
        display-messages = true;
        display-inlay-hints = true;
      };
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        space.x = ":x";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };
  };
  # imv.enable = true;
  thunderbird = {
    enable = true;
    package = pkgs.thunderbird;
    profiles = {};
  };
  ncmpcpp = {
    enable = true;
    settings = {
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_in_stereo = "yes";
      media_library_primary_tag = "album_artist";
    };
    package = pkgs.ncmpcpp.override { visualizerSupport = true; clockSupport = true; };
  };
  mpv.enable = true;
  yt-dlp.enable = true;
  fish = {
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
          rev = "v6.0.1";
          sha256 = "cCI1FDpvajt1vVPUd/WvsjX/6BJm6X1yFPjqohmo1rI=";
        };
      }
    ];
  };
/*
    zsh = {
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
  };
}
