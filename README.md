# idris-project-template

Template for Idris packages. Includes sample Makefile and default.nix files.

Remember that a package can only be an executable or a library, not both.
If you try to use `idris --install` for a package that includes an executable,
then the library ibc files will not be installed.
