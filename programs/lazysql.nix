{ pkgs, ... }:

{
  programs.lazysql = {
    enable = true;
    package = pkgs.unstable.lazysql;
    settings = { };
  };
}
