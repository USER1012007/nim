{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSystem = f: nixpkgs.lib.genAttrs systems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in {
      packages = forEachSystem ({ pkgs }: {
        default = pkgs.stdenv.mkDerivation {
          pname = "main";
          version = "1.0";

          src = ./.;
          buildInputs = [ pkgs.gcc ];
          buildPhase = ''
            g++ -Wno-unused-result main.cpp -o main -lm
          '';
          installPhase = ''
            mkdir -p $out/bin
            cp main $out/bin/
          '';
        };
      });

      apps = forEachSystem ({ pkgs }: {
        default = {
          type = "app";
          program = "${self.packages.${pkgs.system}.default}/bin/main";
        };
      });
    };
}
