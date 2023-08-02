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
  ./hyprland.nix 
  ./services.nix 
  ./programs.nix 
  # ./stylix.nix 
  ./gtk.nix
  ];
    programs.git = {
    enable = true;
    userName = "Basil Keeler";
    userEmail = "basil.keeler@outlook.com";
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhs;
  };
  programs.neovim = {
    enable = true;
  };

  programs.fish = {
    enable = true;
  };
  # programs.fish.interactiveShellInit = "exec hilbish";
  home.packages = with pkgs;[
    gnome.nautilus
    killall
    cope
    fd
    qmmp
    prismlauncher
    jellyfin-mpv-shim
    moonlight-qt
    neofetch
    hyfetch
    cava
    pavucontrol
    discord
    exercism
    ntfsprogs
    qt6.full
    swaybg
    wdisplays
    gcc
    rustup
    swaynotificationcenter
    amberol
    obsidian
    syncthingtray
    syncthing
    wine
    lapce
    mpdevil
  ];
  home = {
    file = {
      ".wallpaper.png".source = ../assets/wallpaper.png;
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
    
      };
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
  };
  systemd.user.targets.tray = {
		Unit = {
			Description = "Home Manager System Tray";
			Requires = [ "graphical-session-pre.target" ];
		};
	};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
