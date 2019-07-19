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

  masterNumpy = pythonPackages.numpy.overrideAttrs(oldAttrs: {
    name = "numpy-master";

    buildInputs = oldAttrs.buildInputs ++ [ pythonPackages.cython ];

    src =  builtins.fetchTarball {
      url = "https://github.com/numpy/numpy/archive/master.tar.gz";
    };
  });
}
