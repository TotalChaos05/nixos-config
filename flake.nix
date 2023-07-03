{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
  };
  outputs = {
    self,
    home-manager,
    hyprland,
    stylix,
    nixpkgs,
    ...
  }: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.t-hon = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        hyprland.nixosModules.default
        stylix.nixosModules.stylix
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
        }
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          #programs.foot.enable = true;
          home-manager.users.basilk = import ./home;
        }
      ];
    };
    homeConfigurations."t-hon" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules = [
        hyprland.homeManagerModules.default
      ];
    };
  };
}
