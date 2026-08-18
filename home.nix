{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.packages = with pkgs; [
    ripgrep
    fd
    jq
    bat
    treemd
    glow
    uv
    go
    unstable.gwq
    unstable.codex
  ];

  home.sessionVariables = {
    UV_SYSTEM_CERTS = "true";
    SUDO_EDITOR = "hx";
  };
  home.sessionPath = [
    "$HOME/go/bin"
  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
        command yazi "$@" --cwd-file="$tmp"
        if cwd="$(<"$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }
    '';

    shellAliases = {
      l = "eza --icons -F -lhg --git --group-directories-first";
      tree = "eza --icons -F -T --group-directories-first";
      lg = "lazygit";
      gl = "glow -p";
      cw = "gwq cd";
      lq = "lazysql";
    };
  };

  programs.zoxide = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    useTheme = "kushal";
  };

  imports = [
    ./programs/eza.nix
    ./programs/git.nix
    ./programs/helix.nix
    ./programs/lazygit.nix
    ./programs/lazysql.nix
    ./programs/yazi.nix
  ];

  home.stateVersion = "26.05";
}
