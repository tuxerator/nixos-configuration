{ lib }:

let
  inherit (builtins) add split stringLength;
  inherit (lib) concatLines isList fold max removeSuffix splitString;
  inherit (lib.strings) replicate;
in
rec {
  frame = color: text:
    let
      lines = splitString "\n" (removeSuffix "\n" text);
      pad = printablePad (fold max 0 (map printableLength lines));
    in
    concatLines ([
      (color "┌───${pad "─" ""}───┐")
      (color "│   ${pad " " ""}   │")
    ] ++ map (l: "${color "│"}   ${pad " " l}   ${color "│"}") lines ++ [
      (color "│   ${pad " " ""}   │")
      (color "└───${pad "─" ""}───┘")
    ]);

  printableLength = text: fold add 0 (map (v: if isList v then 0 else stringLength v) (split "\\[[^m]*m" text));

  printablePad = width: placeholder: text: text + replicate (width - printableLength text) placeholder;
}
