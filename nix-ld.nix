{ config, pkgs, ... }: {
  # Enable nix ld
  programs.nix-ld.dev.enable = true;
  environment.systemPackages = with pkgs; [
    nix-alien
  ];

}