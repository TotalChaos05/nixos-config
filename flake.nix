{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-23.05";
    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
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
      specialArgs = { inherit hyprland hyprland-plugins;};
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
          environment.localBinInPath = true;
        }
      ];
    };
  };
}
