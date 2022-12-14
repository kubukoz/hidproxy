{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.gitignore-source.url = "github:hercules-ci/gitignore.nix";
  inputs.gitignore-source.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, flake-utils, gitignore-source, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.callPackage ./derivation.nix { inherit gitignore-source; };
        checks = {
          defaultPackageBuild = self.defaultPackage.${system};
        };
      }
    );
}
