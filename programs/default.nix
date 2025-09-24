{ ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./tmux.nix
    ./zsh.nix
  ];
  
  programs.home-manager.enable = true;

  programs.neomutt = {
    enable = true;
  };

  programs.zk = {
    enable = true;
  };

  programs.ssh.enable = true;
}
