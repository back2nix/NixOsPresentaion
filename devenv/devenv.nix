{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.pgadmin4-desktopmode
  ];

  # https://devenv.sh/scripts/
  scripts.hello.exec = "echo hello from $GREET";

  enterShell = ''
    hello
    git --version
  '';

  # https://devenv.sh/tests/
  # enterTest = ''
  # echo "Running tests"
  # git --version | grep "2.42.0"
  # '';

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/languages/
  # languages.nix.enable = true;

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";

  # See full reference at https://devenv.sh/reference/options/

  # processes = {
  #   silly-example.exec = "while true; do echo bar && sleep 1; done";
  #   ping.exec = "ping localhost";
  # };

  # services.mongodb = {enable = true;};

  # scripts.enterDB.exec = "${pkgs.usql}/bin/usql postgres://localhost/mydb";

  # https://www.youtube.com/watch?v=WFT5MaZN6g4
  # postgres://localhost:5432/mydb
  services.postgres = {
    enable = true;
    listen_addresses = "0.0.0.0"; # Слушать на всех интерфейсах
    port = 5432; # Стандартный порт PostgreSQL
    package = pkgs.postgresql_15;
    initialDatabases = [{name = "postgres";}];
    extensions = extensions: [
      extensions.postgis
    ];

    initialScript = ''
      CREATE ROLE postgres WITH LOGIN PASSWORD 'postgres' SUPERUSER;
    '';
  };

  # processes.foo = {
  #   silly-example.exec = "while true; do echo foo && sleep 1; done";
  #   ping.exec = "ping localhost";
  # };

  # android.enable = true;
  languages.go.enable = true;
  # languages.go.version = "1.22.5";

  # pre-commit.hooks.unit-tests = {
  #   enable = true;

  #   # The name of the hook (appears on the report table):
  #   name = "Unit tests";

  #   # The command to execute (mandatory):
  #   entry = "make check";

  #   # # The pattern of files to run on (default: "" (all))
  #   # # see also https://pre-commit.com/#hooks-files
  #   # files = "\\.(c|h)$";

  #   # # List of file types to run on (default: [ "file" ] (all files))
  #   # # see also https://pre-commit.com/#filtering-files-with-types
  #   # # You probably only need to specify one of `files` or `types`:
  #   # types = ["text" "c"];

  #   # # Exclude files that were matched by these patterns (default: [ ] (none)):
  #   # excludes = ["irrelevant\\.c"];

  #   # # The language of the hook - tells pre-commit
  #   # # how to install the hook (default: "system")
  #   # # see also https://pre-commit.com/#supported-languages
  #   # language = "system";

  #   # # Set this to false to not pass the changed files
  #   # # to the command (default: true):
  #   # pass_filenames = false;
  # };

  containers."prod".copyToRoot = ./dist;
  containers."prod".startupCommand = "/mybinary serve";
}
