{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bottom
    duf
    dust
    hyperfine
    just
    procs
    sd
    tokei
    watchexec
  ];

  programs.tealdeer = {
    enable = true;
    enableAutoUpdates = false;
    settings.updates = {
      auto_update = true;
      auto_update_interval_hours = 720;
    };
  };
}
