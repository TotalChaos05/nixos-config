{pkgs,lib, ...}:
{
services.gnome-keyring.enable = true;
services.xserver.desktopManager.gnome.enable = true;
}