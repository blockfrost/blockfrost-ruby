with (import <nixpkgs> {});
let
  ruby = ruby_3_1;
  env = bundlerEnv {
    name = "blockfrost-ruby-env";
    inherit ruby;
    gemdir = ./.;
  };
in stdenv.mkDerivation {
  name = "blockfrost-ruby";
  buildInputs = [ env ruby nodejs git rubyPackages_3_1.rake rubyPackages_3_1.rspec ];
}
