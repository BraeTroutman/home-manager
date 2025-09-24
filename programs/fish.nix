{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      hme = "home-manager edit";
      hms = "home-manager switch";
    };
    plugins = [
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
    ];
    functions = {
      fish_prompt = {
        body = ''
          if test -n "$SSH_TTY"
              echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
          end

          echo -n (set_color blue)(prompt_pwd)' '

          set_color -o
          if fish_is_root_user
              echo -n (set_color red)'# '
          end
          echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
          set_color normal'';
      };
    };
    shellInitLast = ''
      sops --decrypt /home/btroutma/.secret.enc.env | source
    '';
  };
}
