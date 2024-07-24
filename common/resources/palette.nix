{ lib }:

let
  inherit (builtins) listToAttrs mapAttrs substring;
  inherit (lib) imap0 mapAttrsRecursive nameValuePair;
  inherit ((import <nix-colors> { }).lib.conversions) hexToRGB;

  ansiNames = [ "black" "red" "green" "yellow" "blue" "magenta" "cyan" "white" ];

  asHex = {
    # Monokai
    black = "#1b1b1b";
    blue = "#66d9ef";
    gray = "#666666";
    green = "#a6e22e";
    orange = "#fd971f";
    purple = "#ae81ff";
    red = "#f92672";
    white = "#f8f8f8";
    yellow = "#e6db74";

    # Extended
    orange-red = "#fc5b2d";
    teal = "#29e0b4";

    # Derived
    alt-blue = "#5ac1d5";
    alt-green = "#93c928";
    alt-orange = "#e1851a";
    alt-orange-red = "#dd4915";
    alt-purple = "#9f60ff";
    alt-red = "#d71b60";
    alt-teal = "#23c7a0";
    alt-yellow = "#cdc367";
    dark-gray = "#3a3a3a";
    dark-purple = "#634994";
    dark-red = "#c4265e";
    light-gray = "#dddddd";
  };
in
asHex // rec {
  ansi =
    let
      base = listToAttrs (imap0 (i: n: nameValuePair n (toString (30 + i))) ansiNames);
      effect = p: mapAttrs (_: a: "${p};${a}") base;
    in
    base // { bold = effect "1"; dim = effect "2" // { italic = effect "2;3"; }; italic = effect "3"; };

  ansiFormat = mapAttrsRecursive (_: a: t: "e[${a}m${t}e[0m") ansi;

  asFloat = mapAttrs (_: cs: map (c: c / 255.0) cs) asInt;

  asInt = mapAttrs (_: h: hexToRGB (substring 1 6 h)) asHex;
}
