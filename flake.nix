{
  description = "Node.js web development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        nodejs = pkgs.nodejs_24; # Change version if needed
      in
      {
        devShells.default = pkgs.mkShell {
          name = "nodejs-web-dev-shell";
          buildInputs = [
            nodejs
            pkgs.nodePackages.npm
            pkgs.nodePackages.yarn     # Uncomment to include yarn
            pkgs.nodePackages.pnpm     # Uncomment to include pnpm
            pkgs.git
          ];

          shellHook = ''
            echo "🚀 Node.js Web Dev Shell ready (Node ${nodejs.version})"
            echo "Use 'npm install' or your package manager of choice"
          '';
        };
      });
}

