{
  pkgs,
  user,
  lib,
  stdenv,
  inputs,
  ...
}:
{
  imports = [
  # ./hyprland.nix 
  ./sway.nix
  ./services.nix 
  ./programs.nix 
  ./stylix.nix 
  ./gtk.nix
  ./audio
  # ./eww
  ];
    programs.git = {
    enable = true;
    userName = "Basil Keeler";
    userEmail = "basil.keeler@outlook.com";
  };
  xdg.enable = true;
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhs;
  };
  programs.neovim = {
    # enable = true;
  };

  programs.fish = {
    enable = true;
  };
  # programs.fish.interactiveShellInit = "exec hilbish";
  home.packages = with pkgs; [
    nemo
    killall
    (callPackage (import ./audio/bitwig.nix) {})
    ludusavi
    cloudflare-warp
    guitarix
    jellyfin-media-player
    grim
    slurp
    wl-clipboard
    # cope
    vcv-rack
    swaybg
    bottles
    prismlauncher
    # jellyfin-mpv-shim
    xdg-utils
    brightnessctl
    moonlight-qt
    cava
    pavucontrol
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    ntfsprogs
    wdisplays
    (swaynotificationcenter.overrideAttrs (oldAttrs: {
      mesonFlags =  ["-Dscripting=false"];
    }))
    obsidian
    syncthingtray
    syncthing
    lapce
    mpdevil
    
    wob
    sov
    iwgtk
    brightnessctl
    terminus_font
    ubuntu_font_family
    wdisplays
    wlogout
    zsh
    gnome.gnome-system-monitor
  ];
  home = {
    file = {
      ".wallpaper.png".source = ../../assets/wallpaper.png;
      #".config/hypr/hyprland.conf".source = dotfiles/hypr/hyprland.conf;
      ".config/hypr/hyprpaper.conf".source = dotfiles/hypr/hyprpaper.conf;
      # Script to unlock ssh-key
      ".local/bin/ssh-unlock".source = dotfiles/ssh-unlock;
      # Catppuccin
      ".config/hypr/mocha.conf".source = dotfiles/hypr/mocha.conf;
      ".config/hypr/frappe.conf".source = dotfiles/hypr/frappe.conf;
      ".config/hypr/macchiato.conf".source = dotfiles/hypr/macchiato.conf;
      ".config/hypr/latte.conf".source = dotfiles/hypr/latte.conf;
      ".config/cava/config".source = dotfiles/cava/config;
      ".local/share/applications/helix.desktop".source = ../assets/helix.desktop;
    
      };
      username = "basilk";
      homeDirectory = "/home/basilk";
    };

  home.stateVersion = "23.05"; # Please read the comment before changing.
  
  gtk.iconTheme = {
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
  };
  # ++ [pkgs-stable.lapce];
  # programs.waybar = import ./waybar.nix;
  # programs.bash.enable = true;
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  # services.mako.enable = true;

  # # Cursor
  # # home.file.".icons/default".source = "${pkgs.catppuccin-cursors.mochaPink}/share/icons/Catppuccin-Mocha-Pink-Cursors";

  # # FONTS

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/basilk/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
    MOZ_ENABLE_WAYLAND = 1;
    FLAKE = "/home/basilk/nixos-config";
  };
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
		Requires = [ "graphical-session-pre.target" ];
    };
  };
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
	

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
