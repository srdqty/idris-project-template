let
  pkgs = import ./nix/nixpkgs-pinned.nix {};

in
  pkgs.stdenv.mkDerivation {
    name = "idris-development-shell";

    buildInputs = [
      pkgs.idris
      pkgs.git
      pkgs.vim
      pkgs.ncurses # Needed by the bash-prompt.sh script
    ];

    shellHook = builtins.readFile ./nix/bash-prompt.sh + ''
      source ${pkgs.git.out}/etc/bash_completion.d/git-prompt.sh
      source ${pkgs.git.out}/etc/bash_completion.d/git-completion.bash
    '';
  }
