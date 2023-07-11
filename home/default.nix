{
  config,
  pkgs,
  lib,
  home-manager, 
  inputs, 
  stateVersion, 
  hostname, 
  hyprland,
  hyprland-plugins,
  #pkgs-stable,
  ...
}: {
  
  
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs stateVersion hostname pkgs hyprland hyprland-plugins; };
    users.basilk = {
      imports = [
        hyprland.homeManagerModules.default
        (import ./home-basilk.nix)
        #(import ./packages)
      ];
    };
  };
  
  
  
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  #home.username = "basilk";
  #home.homeDirectory = "/home/basilk";
  #imports = [
    # ./sway.nix
    #./desktops/hyprland
    # ./desktops/sway
    #./packages
    # ./stylix.nix
  #];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  #home.stateVersion = "23.05"; # Please read the comment before changing.
  # The home.packages option allows you to install Nix packages into your
  # environment.


}
