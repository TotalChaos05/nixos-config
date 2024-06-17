{ inputs }:
(final: prev: {
  bitwig-studio-cracked = prev.callPackage (import ./bitwig) { };
  sublime4 = prev.sublime4.overrideAttrs (oldAttrs: {
    postInstall = ''
      sed -i "s/\x80\x78\x05\x00\x0F\x94\xC1/\xC6\x40\x05\x01\x48\x85\xC9/g;" ./sublime_text
    '';
  });
  vinegar = prev.callPackage (import ./vinegar) { inherit inputs; };
  cosmic-de = with prev.pkgs; (import ./cosmic-de { inherit prev; });
  miniplayer = prev.miniplayer.overrideAttrs {
    src = inputs.miniplayer-src;
    version = "git";
    propagatedBuildInputs = with prev.python3Packages; [
      colorthief
      ffmpeg-python
      mpd2
      pillow
      pixcat
      requests
      ueberzug
      setuptools
    ];
  };
  #gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
  #  mutter = gnomePrev.mutter.overrideAttrs (old: {
  #    src = prev.fetchgit {
  #      url = "https://gitlab.gnome.org/vanvugt/mutter.git";
  #      # GNOME 45: triple-buffering-v4-45
  #      rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
  #      sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
  #    };
  #  });
  #});

  vesktop = prev.vesktop.overrideAttrs (oldAttrs: {
    # version = "1.5.1";
    # src = prev.fetchFromGitHub {
    #   owner = "Vencord";
    #   repo = "Vesktop";
    #   rev = "v1.5.1";
    #   hash = "sha256-OyAGzlwwdEKBbJJ7h3glwx/THy2VvUn/kA/Df3arWQU=";
    # };
    # pnpmDeps = oldAttrs.pnpmDeps.overrideAttrs {
    #   outputHash = "sha256-JLjJZYFMH4YoIFuyXbGUp6lIy+VlYZtmwk2+oUwtTxQ=";
    # };
    preBuild = ''
      cp ${./icon.ico} ./static/icon.ico 
          cp ${./icon.png} ./static/icon.png'';
  });
})
