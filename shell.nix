with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "adventOfCode2023";
  buildInputs = [
    ocamlPackages.base
    ocamlPackages.dune_3
    ocamlPackages.findlib
    ocamlPackages.ocaml
    ocamlPackages.ocaml-lsp
    ocamlPackages.odoc
    ocamlPackages.stdio
    ocamlPackages.utop
    ocamlformat
  ];
  src = null;
}
