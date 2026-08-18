{ pkgs, ... }:

{
  programs.go.enable = true;

  home = {
    packages = with pkgs; [
      delve
      gopls
    ];

    sessionPath = [
      "$HOME/go/bin"
    ];
  };
}
