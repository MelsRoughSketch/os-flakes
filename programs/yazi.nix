{ inputs, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableBashIntegration = false;

    plugins = {
      inherit (pkgs.yaziPlugins) smart-enter;
    };

    flavors = {
      catppuccin-mocha = "${inputs.yazi-flavors}/catppuccin-mocha.yazi";
    };

    theme.flavor = {
      dark = "catppuccin-mocha";
      light = "catppuccin-mocha";
    };

    keymap.mgr.prepend_keymap = [
      {
        on = [ "<Enter>" ];
        run = "plugin smart-enter";
        desc = "Enter the child directory, or open the file";
      }
    ];
  };
}
