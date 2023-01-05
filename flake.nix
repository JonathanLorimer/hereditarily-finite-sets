{
  description = "hereditarily-finite-sets";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    cornelis.url = github:isovector/cornelis;
    agda.url = github:agda/agda/nightly;
  };

  outputs = inputs:
    with inputs.flake-utils.lib;
    eachDefaultSystem (system:

    let
      pkgs = import inputs.nixpkgs {
        inherit system;
      };
      utils = inputs.flake-utils.lib;
      cornelis = inputs.cornelis.packages.${system}.cornelis;
      agda = inputs.cornelis.packages.${system}.agda;
    in
      {
        # nix develop
        devShell =
          pkgs.mkShell {
            buildInputs = with pkgs; [
              cornelis
              agda
            ];
          };
      });
}
