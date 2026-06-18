{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Caleb Hebert";
      user.email = "caleb@linux.com";
      init.defaultBranch = "main";
      core.editor = "emacs";
    };
  };
}
