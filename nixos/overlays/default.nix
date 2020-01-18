{
  # Imports the overlay
  nixpkgs.overlays = [
    (import ./overlay.nix)
  ];
}