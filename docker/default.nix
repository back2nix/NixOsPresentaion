let
  pkgs = import <nixpkgs> {};
in
  pkgs.dockerTools.buildLayeredImage {
    name = "plutus-devcontainer";
    tag = "latest";

    config = {
      Env = [
        "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
        "LANG=C.UTF-8"
      ];

      EntryPoint = ["${pkgs.curl}/bin/curl"];
    };
  }
