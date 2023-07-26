# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./stylix.nix
    ./home
    ./virt.nix
#    ./nix-ld.nix
    #./home-manager/home.nix
    #./home-manager/desktops/gnome.nix
  ];
  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
  };
  services.dbus.enable = true;
  # programs.sway.enable = true;

  # tlp
  services.tlp.enable = true;

  # Allow unfree packages
  security.pam.services.swaylock = {};
  programs.dconf.enable = true;
  programs.fish.enable = true;
  users.users.basilk.shell = pkgs.fish;
  
  programs.ssh.startAgent = true;

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1u"
  ];

  hardware.pulseaudio.enable = false;
  nixpkgs.config = {
    allowUnfree = true;
  };
  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
  ];
  programs.steam.enable = true;

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Media,Socket,Sink,Source";
    };
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };
  # Hyprland Cachix
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  networking.hostName = import ./hostname.nix; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.displayManager.sddm.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.basilk = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      tree
    ];
  };
  security.polkit.enable = true;
  xdg.portal = {
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  services.logind = {
    extraConfig = "HandlePowerKey=suspend";
    lidSwitch = "suspend";
  };

  # Fix spice usb redir
  virtualisation.spiceUSBRedirection.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  nixpkgs.overlays = let
    myOverlay = self: super: {
      discord = super.discord.override {
        withOpenASAR = true;
        withVencord = true;
      };
      ncmpcpp = super.ncmpcpp.override {
        visualizerSupport = true;
        clockSupport = true;
      };
    };
    intelStuff = self:
      pkgs {
        vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
      };

  
  in [ myOverlay ];



  
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };


  environment.systemPackages = [pkgs.firefox-devedition-bin pkgs.emptty];
  /*
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
    vscodium-fhs
    git
    foot
    nyancat
    firefox-devedition-bin
    discord
    bitwarden
    gnomeExtensions.appindicator
    ];
  */

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
    networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # BefWore changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
