{ config, pkgs, ... }:

{
  imports = [
    ./helix.nix
  ];

  #
  # HOME MANAGER CONFIG
  # 
  home.username = "btroutma";
  home.homeDirectory = "/home/btroutma";
  home.stateVersion = "25.05";

  #
  # INSTALLED PACKAGES
  # 
  home.packages = [
    # Red Hat specific dependencies
    pkgs.rosa
    pkgs.ocm
    pkgs.awscli2
    pkgs.openshift
    pkgs.ocm-backplane
    pkgs.terraform
    pkgs.jira-cli-go
    pkgs.saml2aws

    # Claude dependencies
    pkgs.google-cloud-sdk
    pkgs.claude-code

    # General Dependencies
    pkgs.podman
    pkgs.jq
    pkgs.yq
    pkgs.xclip
    pkgs.gnumake42
    pkgs.gcc
    pkgs.ripgrep
    pkgs.asciinema
    pkgs.codespell
    pkgs.sops

    # Langs
    ## Go
    pkgs.go
    pkgs.gopls
    pkgs.delve
    pkgs.ginkgo
    ## Node
    pkgs.nodejs_24
    pkgs.typescript-language-server
    ## Nix
    pkgs.nil
    ## Python
    pkgs.ty
    pkgs.python313Packages.pip
    ## Fish
    pkgs.fish-lsp
    ## HTML
    pkgs.superhtml
    pkgs.prettier
    ## Ruby
    pkgs.ruby
    pkgs.rubyPackages.solargraph
    ## CSS
    pkgs.vscode-langservers-extracted

    # NUR packages
    pkgs.nur.repos.charmbracelet.crush
  ];

  #
  # DIRECT DOTFILES
  # 
  home.file = {};

  #
  # ENVIRONMENT VARIABLES
  # 
  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE=1;
    CLAUDE_CODE_USE_VERTEX=1;
    CLOUD_ML_REGION = "us-east5";
    ANTHROPIC_VERTEX_PROJECT_ID = "itpc-gcp-hcm-pe-eng-claude";
    VERTEXAI_PROJECT = "itpc-gcp-hcm-pe-eng-claude";
    VERTEXAI_LOCATION = "us-east5";
  };

  #
  # PROGRAMS
  # 
  programs.home-manager.enable = true;

  programs.neomutt = {
    enable = true;
  };

  programs.zk = {
    enable = true;
  };

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

  programs.git = {
    enable = true;
    userName = "BraeTroutman";
    userEmail = "btroutma@redhat.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.ssh.enable = true;

  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    extraConfig = ''
      # New panes/windows start in current directory
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
