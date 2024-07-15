{
  description = "Galoy Mobile dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    android = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    # nixpkgs-stable,
    flake-utils,
    android,
    # ruby-nix,
  }:
    {
      overlay = final: prev: {
        inherit (self.packages.${final.system}) android-sdk;
      };
    }
    // flake-utils.lib.eachSystem ["x86_64-linux"] (
      system: let
        overlays = [
          (self: super: {
          })
        ];

        inherit (nixpkgs) lib;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            self.overlay
          ];
        };

        # pkgsStable = import nixpkgs-stable {
        #   inherit system;
        # };

        buildInputs = with pkgs; [
          gnumake
        ];

        nativeBuildInputs = with pkgs; [
          zsh
          jdk17
          gnumake
          which
          android-sdk
          glibcLocalesUtf8
          # wireshark
        ];
      in {
        packages = {
          android-sdk = android.sdk.${system} (sdkPkgs:
            with sdkPkgs; [
              build-tools-34-0-0
              cmdline-tools-latest
              emulator
              platform-tools
              platforms-android-34
              ndk-26-1-10909125
              cmake-3-22-1

              # TODO: Update these obsolete dependencies
              # build-tools-30-0-3
              # build-tools-33-0-1
              # platforms-android-33

              system-images-android-34-google-apis-x86-64
              system-images-android-34-google-apis-playstore-x86-64
            ]);
        };

        devShells.default = pkgs.mkShell {
          inherit buildInputs nativeBuildInputs;

          ANDROID_HOME = "${pkgs.android-sdk}/share/android-sdk";
          ANDROID_SDK_ROOT = "${pkgs.android-sdk}/share/android-sdk";
          JAVA_HOME = pkgs.jdk17.home;

          env = {
            ZDOTDIR = ".";
            # PATH = "${pkgs.gnumake}/bin:$PATH";
          };

          shellHook = ''
            echo -e "\e[34m`cat .nixos.ico`\e[0m"
            if ! avdmanager list avd -c | grep -q Pixel_API_34; then
            ARCH=$( [ "${pkgs.stdenv.targetPlatform.system}" = "aarch64-darwin" ] && echo "arm64-v8a" || echo "x86_64" )
            echo no | avdmanager create avd --force -n Pixel_API_34 --abi "google_apis_playstore/$ARCH" --package "system-images;android-34;google_apis_playstore;$ARCH" --device 'pixel_6a'
            fi
            zsh -c 'zsh'
            exit
          '';
        };
      }
    );
}
# export PATH=${pkgs.which}/bin:$PATH; \
# export PATH=${pkgs.android-sdk}/bin:$PATH; \
# export PATH=${pkgs.wireshark}/bin:$PATH; \
# export PATH=${pkgs.gnumake}/bin:$PATH; \

