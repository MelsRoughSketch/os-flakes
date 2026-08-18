{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];

    settings = {
      theme = "dark_plus";

      editor = {
        end-of-line-diagnostics = "hint";

        inline-diagnostics = {
          cursor-line = "warning";
        };

        lsp = {
          display-inlay-hints = true;
        };

        auto-save.after-delay = {
          enable = true;
          timeout = 800;
        };

        whitespace.render = {
          space = "none";
          tab = "none";
        };

        indent-guides = {
          render = true;
          character = "|";
          skip-levels = 1;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "version-control"
            "spacer"
            "separator"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];

          center = [ ];

          right = [
            "diagnostics"
            "workspace-diagnostics"
            "position"
            "total-line-numbers"
            "position-percentage"
            "file-encoding"
            "file-line-ending"
            "file-type"
            "register"
            "selections"
          ];
        };
      };

      keys = {
        insert = {
          j.k = "normal_mode";
        };

        normal = {
          D = [
            "ensure_selections_forward"
            "extend_to_line_end"
            "delete_selection"
          ];
          space = {
            space = "file_picker_in_current_directory";
            i = ":toggle lsp.display-inlay-hints";
            q = ":quit";
            Q = ":quit!";
            x = ":reset-diff-change";
            "+" = {
              f = ":format";
              w = '':toggle whitespace.render {"default":null,"nbsp":null,"newline":null,"nnbsp":null,"space":"all","tab":"all"} {"default":null,"nbsp":null,"newline":null,"nnbsp":null,"space":"none","tab":"none"}'';
              s = ":toggle soft-wrap.enable";
            };
          };
        };

        select = {
          G = "goto_file_end";
          D = [
            "extend_to_line_bounds"
            "delete_selection"
            "normal_mode"
          ];
          k = [
            "extend_line_up"
            "extend_to_line_bounds"
          ];
          j = [
            "extend_line_down"
            "extend_to_line_bounds"
          ];
        };
      };
    };
  };
}
