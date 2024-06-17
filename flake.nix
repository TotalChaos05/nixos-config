{
  inputs = {
    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/0.1.9.tar.gz";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    coolpkgs.url = "github:totalchaos05/coolpkgs";
    # coolpkgs.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager";
    #home-manager.url = "github:totalchaos05/home-manager";
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
    helix.url = "github:helix-editor/helix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    base16-schemes = {
      flake = false;
      url = "github:tinted-theming/base16-schemes";
    };
    nix-hardware = { url = "github:nixos/nixos-hardware"; };
    kaokao.url = "github:zoe-bat/kaokao";
    kaokao.inputs.nixpkgs.follows = "nixpkgs";

    swayfx = { url = "github:WillPower3309/swayfx"; };

    musnix = { url = "github:musnix/musnix"; };
    nix-gaming.url = "github:fufexan/nix-gaming";
    waybar.url = "github:Alexays/Waybar";
    miniplayer-src = {
      url = "github:totalchaos05/miniplayer";
      flake = false;
    };
    sublime-music.url = "github:sublime-music/sublime-music";
    sublime-music.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager,
    # hyprland,
    kaokao, coolpkgs, stylix, nixpkgs, hyprland-plugins, swayfx,
    # nixpkgs-stable,
    nur, nix-index-database, base16-schemes, nix-hardware, fh,
    #nix-ld,
    #    nix-alien,
    ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (import ./overlays { inherit inputs; })
          nur.overlay
          inputs.fh.overlays.default
        ];
        config.allowUnfree = true;
        config.permittedInsecurePackages =
          [ "electron-24.8.6" "openssl-1.1.1w" ];
      };

      stateVersion = "23.05";
    in {
      nixpkgs.config = {
        allowUnfree = true;
        allowBroken = true;
        # force good practices lmao
        allowAliases = false;
        permittedInsecurePackages = [ "electron-24.8.6" "openssl-1.1.1w" ];
      };
      nixpkgs.overlays = [ nur.overlay ];

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
          { }
          inputs.musnix.nixosModules.musnix
          nix-hardware.nixosModules.common-cpu-intel
          #nix-hardware.nixosModules.common-gpu-intel
          stylix.nixosModules.stylix
          ./hosts/t-hon/configuration.nix
          #home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays =
              [ nur.overlay (import ./overlays { inherit inputs; }) ];

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
          nix-index-database.hmModules.nix-index
          {
            programs.nix-index-database.comma.enable = true;
            programs.nix-index.enable = true;

            nixpkgs.overlays =
              [ nur.overlay (import ./overlays { inherit inputs; }) ];
          }
        ];
        pkgs = pkgs;
        extraSpecialArgs = { inherit inputs stateVersion pkgs; };
      };
    };
}
