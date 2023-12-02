with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "adventOfCode2023";
  buildInputs = [
    ocamlPackages.ocaml
    ocamlPackages.dune_3
    ocamlPackages.findlib
    ocamlPackages.utop
    ocamlPackages.odoc
    ocamlPackages.ocaml-lsp
    ocamlformat
  ];
  src = null;
}
