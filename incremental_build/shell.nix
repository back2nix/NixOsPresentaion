{}: let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.05";
  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };

  opencv = pkgs.python310Packages.opencv4.overrideAttrs (finalAttrs: old: {
    separateDebugInfo = true;
    dontStrip = true;
    cmakeBuildType = "Debug"; # if your wants debug build

    # dontUnpack = true;
    dontPatch = true;
    # dontConfigure = true;
    # dontBuild = true;
    # dontInstall = true;
    doChek = false;

    outputs = [
      "out"
    ];

    # block postUnpack
    postUnpack = '''';

    # bock
    postConfigure = '''';

    # block docs
    postBuild = '''';

    # block test
    preInstall = ''
    '';

    src = ./debug/source; # second run, set: dontPatch = true;
    # Pre Build Path:
    # src = debugSrc; # second run, set: dontPatch = true;
  });
in
  pkgs.mkShell
  {
    name = "custom-opencv4-shell";

    buildInputs = with pkgs; [
      stdenv
      gdb
      cmake
      opencv
    ];
  }
