{pkgs, ...}: {
  # https://github.com/tweag/jupyenv
  kernel.python.science-example = {
    enable = true;
    extraPackages = ps: [ps.numpy ps.scipy ps.matplotlib];
  };
  kernel.python.minimal = {
    enable = true;
  };
  kernel.go.minimal-example = {
    enable = true;
  };
  kernel.c.minimal-example = {
    enable = true;
  };
  kernel.nix.minimal-example = {
    enable = true;
  };
}
