# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs ? import <nixpkgs> { } }: {
  spaget = pkgs.callPackage ./spaget { target = "everyone"; };
  # wip = pkgs.callPackage ./wip {};
}
