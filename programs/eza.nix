{ inputs, ... }:

{
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    icons = "auto";
    git = true;
  };

  xdg.configFile."eza/theme.yml".source =
    "${inputs.eza-themes}/themes/catppuccin-mocha.yml";
}
