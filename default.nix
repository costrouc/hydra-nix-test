{ pkgs ? import <nixpkgs> { }, pythonPackages ? pkgs.python3Packages }:

rec {
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

    # <numpy> = https://github.com/costrouc/numpy.git
    src = <numpy>;
  });

  my_package = pythonPackages.buildPythonPackage {
    pname = "my_package";
    version = "1.1";

    src = ./.;

    propagatedBuildInputs = [ masterNumpy ];
  };
}
