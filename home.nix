
{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.packages = with pkgs; [
    ripgrep
    fd
    jq
    bat
  ];

  programs.git = {
    enable = true;
    settings = {
      
      user = {
        name = "MelsRoughSketch";
        email = "106862952+MelsRoughSketch@users.noreply.github.com";
      };
    };
  };

  home.stateVersion = "26.05";
}
