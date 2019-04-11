let
  pkgs = import ./nix/nixpkgs {};

  idrisWithPackages = pkgs.idrisPackages.with-packages (with pkgs.idrisPackages; [
    prelude
    base
    contrib
  ]);
in
{ stdenv ? pkgs.stdenv
, idris ? pkgs.idris
, gmp ? pkgs.gmp
}:
  stdenv.mkDerivation {
    name = "idris-project-template";

    src = ./.;

    makeFlags = [ "INSTALL_ROOT=$(out)" ];

    buildInputs = [
      idris
      gmp
    ];
  }
