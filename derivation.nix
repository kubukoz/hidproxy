{ pkgs, stdenv, installShellFiles, lib, darwin, openssl, pkg-config, zlib, gitignore-source }:
let cargo_nix = import ./Cargo.nix { inherit pkgs; }; in

cargo_nix.rootCrate.build.overrideAttrs (prev: {
  src = gitignore-source.lib.gitignoreSource ./.;

  buildInputs = prev.buildInputs ++ [
    openssl
    pkgs.rustfmt
    pkgs.crate2nix
  ];
  nativeBuildInputs = prev.nativeBuildInputs ++
    lib.optionals stdenv.isDarwin [
      pkgs.darwin.apple_sdk.frameworks.AppKit
      pkg-config
      zlib
      pkgs.hidapi
    ];

  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
})
