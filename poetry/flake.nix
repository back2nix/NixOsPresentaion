{
  description = "python flake template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  inputs.poetry2nix = {
    url = "github:nix-community/poetry2nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    poetry2nix,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        poetry2nix' = import poetry2nix {inherit pkgs;};
        overrides = poetry2nix'.defaultPoetryOverrides.extend (self: super: {
          nh3 = super.nh3.override {preferWheel = true;};
          frida-tools = super.frida-tools.overridePythonAttrs (old: {
            buildInputs = (old.buildInputs or []) ++ [super.setuptools];
          });
          urwid-mitmproxy = super.urwid-mitmproxy.overridePythonAttrs (old: {
            buildInputs = (old.buildInputs or []) ++ [super.setuptools];
          });
        });

        env-wheel = poetry2nix'.mkPoetryEnv {
          python = pkgs.python312;
          pyproject = ./pyproject.toml;
          poetrylock = ./poetry.lock;
          preferWheels = true;
          inherit overrides;
        };

        nativeBuildInputs = with pkgs.python312Packages; [
          pkgs.which
          env-wheel
          pip
          python
          pkgs.xz
          pkgs.wget
          pkgs.git
          pkgs.zsh
          pkgs.poetry
          poetry-core
        ];

        buildInputs = with pkgs; [];
      in {
        devShells.default = pkgs.mkShell {
          inherit nativeBuildInputs buildInputs;
          name = "python flake template";
          shellHook = ''
            # echo "Launching 'python flake template' shell"
            echo -e "\e[34m`cat .nixos.ico`\e[0m"
            zsh
            exit
          '';

          env = {
            ZDOTDIR = ".";
            # HOME = "";
          };
        };
      }
    );
}
