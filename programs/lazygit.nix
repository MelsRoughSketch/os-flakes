{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        language = "ja";
        nerdFontsVersion = "3";
      };

      git = {
        remoteBranchSortOrder = "alphabetical";

        branchLogCmd = ''
          sh -c "git log --graph --color=always --decorate --pretty=tformat:'%C(auto)%h%Creset - %C(auto)%d%Creset %Cgreen(%cr)%Creset %C(bold blue)<%an>%Creset%n            %s%n' {{branchName}} -- | sed -e s/\\*/●/ -e s/\\|/│/"
        '';

        allBranchesLogCmds = [
          ''
            sh -c "git log --graph --all --color=always --decorate --pretty=tformat:'%C(auto)%h%Creset - %C(auto)%d%Creset %Cgreen(%cr)%Creset %C(bold blue)<%an>%Creset%n            %s%n' -- | sed -e s/\\*/●/ -e s/\\|/│/"
          ''
        ];

        pagers = [
          {
            colorArg = "always";
            pager = "delta --dark --paging=never --side-by-side --line-numbers";
          }
        ];

        fetchAll = true;
        autoFetch = true;
      };

      customCommands = [
        {
          key = "w";
          context = "worktrees";
          description = "ワークツリー作成";

          prompts = [
            {
              type = "input";
              title = "新しいブランチ名";
              key = "BranchName";
            }
          ];

          command = "gwq add -b {{.Form.BranchName}}";
        }

        {
          key = "w";
          context = "localBranches";
          description = "ワークツリー作成";
          command = "gwq add {{.SelectedLocalBranch.Name}}";
        }

        {
          key = "w";
          context = "remoteBranches";
          description = "ワークツリー作成";
          command = "gwq add {{.SelectedRemoteBranch.Name}}";
        }

        {
          key = "s";
          context = "worktrees";
          description = "状態";
          command = "gwq status";
          output = "logWithPty";
        }
      ];

      os = {
        editPreset = "helix";
      };
    };
  };
}
