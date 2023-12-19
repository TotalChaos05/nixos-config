{pkgs,lib, ...}:
{
services.xserver.enable = true;
services.xserver.displayManager.gdm.enable = true;
services.gnome.gnome-keyring.enable = true;
services.xserver.desktopManager.gnome.enable = true;
environment.systemPackages = with pkgs; [ 
gnomeExtensions.espresso 
gnomeExtensions.appindicator 
gnome.gnome-tweaks 
gnomeExtensions.blur-my-shell
gnome-extension-manager
gnomeExtensions.dash-to-dock
gnomeExtensions.dash-to-panel
gnomeExtensions.gtk4-desktop-icons-ng-ding
];
services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
services.tlp.enable = lib.mkForce false;
services.auto-cpufreq.enable = lib.mkForce false;
 xdg.portal = lib.mkForce {
    enable = true;
    wlr.enable = false;
  };
services.gnome.gnome-settings-daemon.enable = true;
programs.dconf.enable = true;

}
