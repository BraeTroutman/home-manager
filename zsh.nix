{ ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "eastwood";
      plugins = ["git"];
    };
    shellAliases = {
      # home manager
      hme = "home-manager edit";
      hms = "home-manager switch";
      # git
    };
    initContent = ''
        complete -C '/home/btroutma/.nix-profile/bin/aws_completer' aws
      '';
  };
}
