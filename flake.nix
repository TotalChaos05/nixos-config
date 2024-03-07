{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    coolpkgs.url = "github:totalchaos05/coolpkgs";
    # coolpkgs.inputs.nixpkgs.follows = "nixpkgs";

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
    xdph.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    xdph.inputs.nixpkgs.follows = "nixpkgs";
    # base16.url = "github:SenchoPens/base16.nix";
    # stylix.inputs.base16.follows = "base16";
    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs"; # override this repo's nixpkgs snapshot
    };
    helix.url = "github:helix-editor/helix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    base16-schemes = {
      flake = false;
      url = "github:tinted-theming/base16-schemes";
    };
    nix-hardware = {
      url = "github:nixos/nixos-hardware";
    };
    kaokao.url = github:zoe-bat/kaokao;
    kaokao.inputs.nixpkgs.follows = "nixpkgs";

    musnix  = { url = "github:musnix/musnix"; };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-gaming.url = "github:fufexan/nix-gaming";    
  };
  outputs = {
    home-manager,
    # hyprland,
    kaokao,
    coolpkgs,
    stylix,
    nixpkgs,
    hyprland-plugins,
    # nixpkgs-stable,
    nur,
    nix-index-database,
    base16-schemes,
    nix-hardware,
    nix-flatpak,
    #nix-ld,
    #    nix-alien,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    overlays = [ (import ./overlays {inherit inputs;})];

    pkgs = import nixpkgs {
      inherit system;
      inherit overlays;
      config.allowUnfree = true;
      config.permittedInsecurePackages = [
        "electron-24.8.6"

      ];
    };

    stateVersion = "23.05";
  in {
    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = true;
      permittedInsecurePackages = [
        "electron-24.8.6"

      ];
    };
    nixpkgs.overlays = [
      nur.overlay
    ];

    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.t-hon = nixpkgs.lib.nixosSystem {
      specialArgs.inputs = inputs;
      specialArgs = {
        #inherit
        #hyprland
        #hyprland-plugins;
      };
      system = "x86_64-linux";
      modules = [
        # QUICK FIXES FOR SHIT
        {
        }
        inputs.musnix.nixosModules.musnix
        nix-hardware.nixosModules.common-cpu-intel
        nix-hardware.nixosModules.common-gpu-intel
        #        nix-ld.nixosModules.nix-ld
        #hyprland.nixosModules.default
        stylix.nixosModules.stylix
        nix-flatpak.nixosModules.nix-flatpak
        ./hosts/t-hon/configuration.nix
        #home-manager.nixosModules.home-manager
        inputs.nh.nixosModules.default
        {

          nixpkgs.overlays = [
            nur.overlay
            (import ./overlays {inherit inputs;})
          ];

          nh = {
            enable = true;
            clean.enable = true;
            clean.extraArgs = "--keep-since 4d --keep 3";
          };
          environment.localBinInPath = true;
            
          nixpkgs.config.allowUnfree = true;
        }
        nur.nixosModules.nur
      ];
    };
    homeConfigurations.basilk = home-manager.lib.homeManagerConfiguration {
      modules = [
        ./home/basilk/home.nix
        stylix.homeManagerModules.stylix
        nix-flatpak.homeManagerModules.nix-flatpak
        nix-index-database.hmModules.nix-index
        {
          programs.nix-index-database.comma.enable = true;
          programs.nix-index.enable = true;

          nixpkgs.overlays = [
            nur.overlay
            (import ./overlays {inherit inputs;})
          ];
        }
      ];
      pkgs = pkgs;
      extraSpecialArgs = {inherit inputs stateVersion pkgs;};
    };
  };
}
