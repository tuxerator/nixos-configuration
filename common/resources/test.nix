{ pkgs ? import <nixpkgs> { } }:

let
  inherit (pkgs) lib;
  palette = import ./palette.nix { inherit lib; };
in
{
  test = palette.ansiFormat.cyan;
}
