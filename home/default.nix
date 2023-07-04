{
  config,
  pkgs,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "basilk";
  home.homeDirectory = "/home/basilk";
  imports = [
    # ./sway.nix
    ./waybar.nix
    # ./stylix.nix
  ];
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    systemdTarget = "graphical-session.target";
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
      }
      {
        timeout = 6;
        command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -F -l -f -c 000000";
      }
    ];
  };
  programs.git = {
    enable = true;
    userName = "Basil Keeler";
    userEmail = "basil.keeler@outlook.com";
  };

  programs.swaylock = {
    enable = true;
    settings = {
      image = lib.mkDefault "~/wallpaper.png";
      scaling = "fill";
    };
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
  };
  programs.foot.enable = true;
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  programs.rbw = {
    enable = true;
  };

  services.gammastep = {
    enable = true;
    tray = true;
    provider = "manual";
    latitude = 32.9546;
    longitude = 97.0150;
    temperature.night = 2000;
  };
  home.packages = with pkgs; [
    # pkgs.hello
    # pkgs.catppuccin-gtk
    nwg-dock-hyprland
    jellycli
    sshuttle
    gnome.nautilus
    pavucontrol
    alejandra
    #hyprpaper
    swaybg
    catppuccin-cursors
    mosh
    q4wine
    wine
    winetricks
    sonixd
    killall
    localsend
    jellyfin-mpv-shim
    gnome.gnome-system-monitor
    vim
    neovim
    wget
    pika-backup
    gparted
    neofetch
    virt-manager
    gnome.gnome-tweaks
    aria
    libvirt
    qemu
    spice
    win-spice
    spice-gtk
    ntfsprogs
    nyancat
    #firefox-devedition-bin
    discord
    pinentry-curses
    bitwarden
    swayidle
    qt6.full
  ];

  services.mpris-proxy.enable = true;
  services.playerctld = {
    enable = true;
    package = pkgs.playerctl;
  };
  # programs.waybar = import ./waybar.nix;
  # programs.bash.enable = true;
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".wallpaper.png".source = ../assets/wallpaper.png;

    ".config/hypr/hyprland.conf".source = dotfiles/hypr/hyprland.conf;
    ".config/hypr/hyprpaper.conf".source = dotfiles/hypr/hyprpaper.conf;

    # Catppuccin
    ".config/hypr/mocha.conf".source = dotfiles/hypr/mocha.conf;
    ".config/hypr/frappe.conf".source = dotfiles/hypr/frappe.conf;
    ".config/hypr/macchiato.conf".source = dotfiles/hypr/macchiato.conf;
    ".config/hypr/latte.conf".source = dotfiles/hypr/latte.conf;
  };

  services.mako.enable = true;

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
