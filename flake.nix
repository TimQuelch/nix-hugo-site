{
  description = "test website";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs@{ nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        deps = [ pkgs.hugo ];
      in
      {
        devShells.default = pkgs.mkShell { packages = deps; };
        packages.default = pkgs.stdenv.mkDerivation {
          name = "drewdevault.com";
          src = ./.;
          buildInputs = deps;
          buildPhase = "hugo";
          installPhase = ''
            mkdir -p $out
            mv public/* $out;
          '';
        };
      }
    );
}
