let
  pkgs = import ./nix/nixpkgs-pinned.nix {};

  my-pkg = pkgs.idrisPackages.callPackage ./default.nix { };

  idrisPackages = pkgs.idrisPackages.with-packages [
    my-pkg
  ];
in
  pkgs.stdenv.mkDerivation {
    name = "test";
    buildInputs = [
      idrisPackages
    ];
  }
