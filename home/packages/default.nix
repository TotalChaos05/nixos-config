{pkgs, ...}:
{
  home.packages = with pkgs; [
    # pkgs.hello
    # pkgs.catppuccin-gtk
    # Important packages 
    pavucontrol
    gnome.nautilus
    gnome.gnome-system-monitor
    killall
    wget
    pika-backup
    neofetch
    aria
    discord
    mosh
    python3
    sshuttle
    
    # Media
    ntfsprogs
    nyancat
    jellycli
    amberol
    cava
    cavalier
    sonixd
    jellyfin-mpv-shim
    
    # Dev
    lapce
    exercism
    sublime4
    vim
    neovim
    alejandra
    
    # swaywm-adjacent
    #hyprpaper
    swaybg
    #nwg-dock-hyprland
    wdisplays
    
    # Bitwarden
    pinentry-curses
    bitwarden
    
    
    # Other???
    gnome.gnome-tweaks
    catppuccin-cursors
    localsend
    #firefox-devedition-bin
    qt6.full
  ]
  # ++ import ./virt.nix pkgs
  # ++ import ./wine.nix pkgs;
  ;
}