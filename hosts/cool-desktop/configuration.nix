# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ config, pkgs, inputs, lib, nix-hardware, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./stylix.nix
    ./virt.nix
    ./nix-ld.nix
    # inputs.nix-gaming.nixosModules.pipewireLowLatency
    #./gnome.nix
    #./home-manager/home.nix
    #./home-manager/desktops/gnome.nix
  ];
  #  boot.kernelPackages=pkgs.linuxPackages_lqx;
  #  environment.etc = {
  #  "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
  #   context.properties = {
  #      default.clock.rate = 48000
  #      default.clock.quantum = 32
  #      default.clock.min-quantum = 32
  #      default.clock.max-quantum = 32
  #    }
  #  '';
  #};
  # syncs nix-channel to flake
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
    magicOrExtension = "\\x7fELF....AI\\x02";
  };
  programs = {
    gamemode.enable = true;
    light.enable = true;
    dconf.enable = true;
    fish.enable = true;
    ssh.startAgent = true;
    steam.enable = true;
    nh.enable = true;

    sway = {
      enable = true;
      package = pkgs.swayfx;
    };
  };

  services = {
    gnome.gnome-keyring.enable = true;
    flatpak.enable = true;
    colord.enable = true;
    gvfs.enable = true;
    blueman.enable = true;
    auto-cpufreq.enable = true;
    thermald.enable = true;

    dbus = {
      enable = true;
      implementation = "broker";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;
      #lowLatency = {
      # enable this module
      #  enable = true;
      # defaults (no need to be set unless modified)
      #  quantum = 64;
      #  rate = 48000;
      #};
    };
    logind = {
      extraConfig = "HandlePowerKey=suspend";
      lidSwitch = "suspend";
    };

    earlyoom = {
      enable = true;
      enableNotifications = true;
    };

    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };

    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
    };
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
  };

  services.xserver = {
    enable = true;
    displayManager = { gdm.enable = true; };
    desktopManager = {
      gnome = {
        enable = true;
        extraGSettingsOverridePackages = with pkgs;
          [
            gnome.nautilus
            #gnome.mutter # should not be needed
            #gtk4 # should not be needed
          ];
      };
    };
  };

  system.extraSystemBuilderCmds = ''
    ln -sv ${pkgs.path} $out/nixpkgs
  '';
  powerManagement.cpuFreqGovernor = lib.mkForce "powersave";
  virtualisation.waydroid.enable = true;

  musnix.enable = true;

  virtualisation.libvirtd.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-compute-runtime
    libvdpau-va-gl
    intel-media-driver
    intel-vaapi-driver
  ];

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart =
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  #virtualisation = {
  #  waydroid.enable = true;
  #  lxd.enable = true;
  #};
  # security.pki.certificateFiles = ["/home/basilk/Cloudflare-CA.pem"];
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
      # For Nixos version > 22.11
      #defaultNetwork.settings = {
      #  dns_enabled = true;
      #};
    };
  };
  # allows access to rpi pico
  services.udev.extraRules = ''

        SUBSYSTEM=="usb", \
        ATTRS{idVendor}=="2e8a", \
        ATTRS{idProduct}=="0003", \
        MODE="660", \
        GROUP="dialout"
        SUBSYSTEM=="usb", \
        ATTRS{idVendor}=="2e8a", \
        ATTRS{idProduct}=="000a", \
        MODE="660", \
        GROUP="dialout"
        SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="dialout"


    # Docs! https://www.freedesktop.org/software/systemd/man/udev.html

    # The commented out stuff is covered by setting programs.steam.enable=true now (in nixos)

    # Gamepad emulation for remote streaming
    # see https://steamcommunity.com/app/221410/discussions/0/523897277912430760/
    # and https://www.kernel.org/doc/html/v5.4/input/uinput.html
    # KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess"

    # Valve USB devices
    # SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", TAG+="uaccess"
    # Valve HID devices (USB hidraw)
    # KERNEL=="hidraw*", ATTRS{idVendor}=="28de", TAG+="uaccess"
    # Valve HID devices (bluetooth hidraw)
    # KERNEL=="hidraw*", ATTRS{idVendor}=="*28DE:*", TAG+="uaccess"

    # DualShock 4 (USB hidraw)
    # KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", TAG+="uaccess"
    # DualShock 4 wireless adapter (USB hidraw)
    # KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ba0", TAG+="uaccess"
    # DualShock 4 Slim (USB hidraw)
    # KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", TAG+="uaccess"
    # DualShock 4 (bluetooth hidraw)
    # KERNEL=="hidraw*", KERNELS=="*054C:05C4*", TAG+="uaccess"
    # DualShock 4 Slim (bluetooth hidraw)
    # KERNEL=="hidraw*", KERNELS=="*054C:09CC*", TAG+="uaccess"

    # Nintendo Switch Pro controller (USB hidraw)
    # KERNEL=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="2009", TAG+="uaccess"
    # Nintendo Switch Pro controller (bluetooth hidraw)
    # KERNEL=="hidraw*", KERNELS=="*057E:2009*", TAG+="uaccess"

    # Switch Joy-con (L) (Bluetooth)
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:057E:2006.*", TAG+="uaccess"
    # Switch Joy-con (R) (Bluetooth)
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:057E:2007.*", TAG+="uaccess"
    # Switch Joy-con charging grip (USB only)
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="200e", TAG+="uaccess"

    # Google Stadia controller (USB)
    KERNEL=="hidraw*", ATTRS{idVendor}=="18d1", ATTRS{idProduct}=="9400", TAG+="uaccess"
  '';

  # services.power-profiles-daemon.enable = false;
  #services.tlp.enable = lib.mkAfter lib.mkIf (config.services.power-profiles-daemon == false) true;
  # services.auto-cpufreq.enable = lib.mkAfter lib.mkIf (config.services.power-profiles-daemon == false) true;
  # services.tlp.enable = true;
  services.tlp = {
    enable = false;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "powersave"; # "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "power"; # "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 40;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;
    };
  };
  security.pam.services.swaylock = { };

  fonts.fontconfig.enable = true;
  users.users.basilk.shell = pkgs.fish;

  nixpkgs.config.permitInsecurePackages = true;
  nixpkgs.config.permittedInsecurePackages =
    [ "openssl-1.1.1u" "electron-24.8.6" ];

  hardware.pulseaudio.enable = false;
  nixpkgs.config = { allowUnfree = true; };

  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-lgc-plus
  ];
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot =
    true; # powers up the default Bluetooth controller on boot
  security.rtkit.enable = true;

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
      "https://helix.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://eigenvalue.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "eigenvalue.cachix.org-1:ykerQDDa55PGxU25CETy9wF6uVDpadGGXYrFNJA3TUs="
    ];
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

  networking.hostName = "t-hon"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  users.users.basilk = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "render"
      "video"
      "dialout"
      "realtime"
      "audio"
      "libvirtd"
    ];
    packages = with pkgs; [ firefox tree ];
  };
  security.polkit.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  xdg.portal.extraPortals = [
    (lib.mkIf (config.services.xserver.desktopManager.gnome.enable == false)
      pkgs.xdg-desktop-portal-gtk)
    pkgs.xdg-desktop-portal-cosmic
  ];

  virtualisation.spiceUSBRedirection.enable = true;

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
      vaapiIntel = super.vaapiIntel.override { enableHybridCodec = true; };
    };
  in [ myOverlay ];

  environment.systemPackages = [
    pkgs.firefox-devedition-bin
    pkgs.home-manager
    pkgs.comma
    pkgs.vulkan-validation-layers
    pkgs.libva-utils
    pkgs.virt-manager
    pkgs.wineasio
    pkgs.wineWowPackages.waylandFull
    pkgs.winetricks
    pkgs.alsa-plugins
    pkgs.alsa-tools
    pkgs.wl-clipboard
    pkgs.ffmpeg
    pkgs.unzip
    pkgs.ripgrep
    pkgs.gjs
  ]; # ++ pkgs.cosmic-de;

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [{
      from = 1714;
      to = 1764;
    } # KDE Connect
      ];
    allowedUDPPortRanges = [{
      from = 1714;
      to = 1764;
    } # KDE Connect
      ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # BefWore changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
