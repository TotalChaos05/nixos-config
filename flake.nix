{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    #nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-23.05";
    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    #hyprland.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    xdph.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    xdph.inputs.nixpkgs.follows = "nixpkgs";
    base16.url = "github:SenchoPens/base16.nix";
    stylix.inputs.base16.follows = "base16";
    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs"; # override this repo's nixpkgs snapshot
    };
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
  }@inputs: 
    let
      system = "x86_64-linux";
      
      pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    };
      
      hostname = import ./hostname.nix;
      stateVersion = "23.05";

    in {
    nixpkgs.config.allowUnfree = true;
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      specialArgs.inputs = inputs;
      specialArgs = { inherit 
      #hyprland 
      hyprland-plugins;};
      system = "x86_64-linux";
      modules = [
#        nix-ld.nixosModules.nix-ld
        #hyprland.nixosModules.default
        stylix.nixosModules.stylix
        ./configuration.nix
        #home-manager.nixosModules.home-manager
	      inputs.nh.nixosModules.default

        {
	        nh = {
            enable = true;
            clean.enable = true;
            clean.extraArgs = "--keep-since 4d --keep 3";
          };
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
    homeConfigurations.basilk = home-manager.lib.homeManagerConfiguration {
      modules = [
        ./home/home-basilk.nix 
        stylix.homeManagerModules.stylix
        ];
      pkgs = pkgs;
      extraSpecialArgs = { inherit hostname inputs stateVersion pkgs; };
    };
  };
}
