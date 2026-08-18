{
  programs = {
    git = {
      enable = true;

      settings = {
        user = {
          name = "MelsRoughSketch";
          email = "106862952+MelsRoughSketch@users.noreply.github.com";
        };

        init.defaultBranch = "main";
        fetch.prune = true;
        rerere.enabled = true;
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
      };
    };
  };
}
