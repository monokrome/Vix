with import <nixpkgs> {}; stdenv.mkDerivation {
  name = "vix";
  src = ./.;

  buildInputs = [
    pkgs.godot
    pkgs.godot_headers
    pkgs.clang
  ];

  meta = {
    homepage = "https://github.com/monokrome/vix";
    description = "Vix.";
  };
}
