final: prev: {
  ocm-backplane = final.callPackage ./backplane.nix { };
  rosa-nightly = final.callPackage ./rosa-nightly.nix { };
  gabi-cli = final.callPackage ./gabi-cli.nix { };
  rosa-1-2-62 = final.callPackage ./rosa1.2.62.nix { };
  brush = final.callPackage ./crush.nix { };
}
