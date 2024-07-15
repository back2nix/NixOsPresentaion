{}: let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.05";
  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };
in {
  opencv = pkgs.python310Packages.opencv4.overrideAttrs (finalAttrs: old: {
    separateDebugInfo = true;
    dontStrip = true;
    cmakeBuildType = "Debug"; # if your wants debug build

    # dontUnpack = true;
    # dontPatch = true;
    # dontBuild = true;
    # dontConfigure = true;
    # dontInstall = true;
    # dontFixup = true;
    doChek = false;

    outputs = [
      "out"
    ];

    postConfigure =
      old.postConfigure
      + ''
        cp -r ../../source $out
        mv $out/build $out/build_bk
        echo Path out:
        echo $out
      '';

    preInstall = '''';

    phaseInstall = '''';

    postInstall =
      old.postInstall
      + ''
        # make -j$(nproc)
        echo Pre Build Path:
        echo $out

        mkdir -p $out/build
        cp -r * $out/build

        cp $out/lib/pkgconfig/opencv4.pc $out/build/unix-install/opencv4.pc
      '';

    installCheckPhase = '''';
    # preDistPhases = '''';
    # distPhase = '''';
    # postPhases = '''';

    # first run so the stalemate can apply
    src = builtins.fetchGit {
      shallow = true;
      url = ./stage1/source; # without prebuild, only source
    };
  });
}
