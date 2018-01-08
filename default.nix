{ prelude
, base
, build-idris-package
}:

build-idris-package {
  name = "idris-project-template";
  src = ./.;
  propagatedBuildInputs = [
    prelude
    base
  ];
}
