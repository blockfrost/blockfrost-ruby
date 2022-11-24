with import <nixpkgs> {};
let
  gems = bundlerEnv {
    name = "blockfrost-ruby";
    inherit ruby;
    gemdir  = ./.;
  };
in stdenv.mkDerivation {
  name = "blockfrost-ruby";
  src = ./.;

  installPhase = ''
    mkdir -p $out
    cp -r $src $out
  '';
}
