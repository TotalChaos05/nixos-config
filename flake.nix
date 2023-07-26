{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-23.05";
    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      # inputs.hyprland.follows = "hyprland";
    };
    base16.url = "github:SenchoPens/base16.nix";
    stylix.inputs.base16.follows = "base16";
#    nix-ld.url = "github:Mic92/nix-ld";
#    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
#    nix-alien.url = "github:thiagokokada/nix-alien";
#    nix-alien.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    home-manager,
    # hyprland,
    stylix,
    nixpkgs,
    hyprland-plugins,
    nixpkgs-stable,
    nur,
    
#    nix-ld,
#    nix-alien,
    ...
  }: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.${import ./hostname.nix} = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit 
      #hyprland 
      hyprland-plugins;};
      system = "x86_64-linux";
      modules = [
#        nix-ld.nixosModules.nix-ld
        #hyprland.nixosModules.default
        stylix.nixosModules.stylix
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          environment.localBinInPath = true;
          nixpkgs.overlays = [
            nur.overlay 
 #           nix-alien.overlays.default
          ];
          nixpkgs.config.allowUnfree = true;
          }
        nur.nixosModules.nur
      ];
    };
  };
}
