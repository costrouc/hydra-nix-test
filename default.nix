{ pkgs ? import <nixpkgs> { }, pythonPackages ? pkgs.python3Packages }:

{
  hydra-nix-test = pkgs.stdenv.mkDerivation rec {
    name = "hydra-nix-test-${version}";
    version = "1.0";

    src = ./.;

    installPhase = ''
      make install PREFIX=$out
    '';
  };
}
