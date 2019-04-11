let
  pkgs = import ./nix/nixpkgs {};

  idris = pkgs.idrisPackages.with-packages (with pkgs.idrisPackages; [
    prelude
    base
    contrib
  ]);
in
  pkgs.stdenv.mkDerivation {
    name = "idris-development-shell";

    buildInputs = [
      pkgs.ncurses # Needed by the bash-prompt.sh script
      idris
      pkgs.gmp.dev
    ];

    shellHook = builtins.readFile ./nix/bash-prompt.sh;
  }
