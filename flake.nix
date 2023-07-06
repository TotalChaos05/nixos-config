{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-23.05";   
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
  };
  outputs = {
    home-manager,
    hyprland,
    stylix,
    nixpkgs,
    hyprland-plugins,
    nixpkgs-stable,
    ...
  }: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.t-hon = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        hyprland.nixosModules.default
        {programs.hyprland.enable = true;}
        stylix.nixosModules.stylix
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.basilk = import ./home;
          environment.localBinInPath = true;
        }
      ];
    };
    homeConfigurations."basilk@t-hon" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules = [
        hyprland.homeManagerModules.default
        {wayland.windowManager.hyprland.enable = true;}
        ];
      #wayland.windowManager.hyprland = 
          
    };
  };
}
