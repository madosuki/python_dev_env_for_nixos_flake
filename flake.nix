{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
        {
          devShells.default = with pkgs; mkShell {
            buildInputs = [
              uv
              poetry
              pkg-config
              openssl
              sqlite
              zlib
              readline
              xz
              libffi.dev
              expat
              stdenv.cc.cc.lib
              bzip2
              libxml2
              util-linux
            ];
            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
              pkgs.libffi
            ];
            shellHook = ''
            exec zsh
            '';
          };
        }
    );
}
