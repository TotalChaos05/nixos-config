{inputs}:
(final: prev: {
  bitwig-studio-cracked = prev.callPackage (import ./bitwig) {};
  vinegar = prev.callPackage (import ./vinegar) {inherit inputs;};
  cosmic-de = with prev.pkgs; (import ./cosmic-de {inherit prev;});
})
