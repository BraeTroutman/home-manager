{ ... }:

{
  programs.git = {
    enable = true;
    userName = "BraeTroutman";
    userEmail = "btroutma@redhat.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
