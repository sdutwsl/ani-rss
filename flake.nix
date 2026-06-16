{
  description = "ani-rss development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            git
            jdk17
            maven
            nodejs
            pnpm
            jetbrains.idea-oss
          ];

          shellHook = ''
            echo "ani-rss dev shell"
            echo "  java:  $(java --version 2>&1 | head -1)"
            echo "  maven: $(mvn --version 2>&1 | head -1)"
            echo "  node:  $(node --version)"
            echo "  pnpm:  $(pnpm --version)"
          '';
        };
      }
    );
}
