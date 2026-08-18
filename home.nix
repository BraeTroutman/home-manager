{ config, pkgs, ... }:

{
  imports = [
    ./programs
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
    pkgs.rosa-nightly
    pkgs.rosa-1-2-62
    pkgs.vault
    pkgs.ocm
    pkgs.awscli2
    pkgs.openshift
    pkgs.ocm-backplane
    pkgs.terraform
    pkgs.jira-cli-go
    pkgs.saml2aws
    pkgs.stern
    pkgs.gabi-cli
    pkgs.bitwarden-cli

    # Claude dependencies
    pkgs.google-cloud-sdk
    pkgs.claude-code

    # General Dependencies
    pkgs.podman
    pkgs.podman-compose
    pkgs.jq
    pkgs.yq
    pkgs.xclip
    pkgs.gnumake42
    pkgs.gcc
    pkgs.ripgrep
    pkgs.asciinema
    pkgs.asciinema-agg
    pkgs.codespell
    pkgs.sops
    pkgs.just
    pkgs.zlib

    # Langs
    ## Go
    pkgs.go_1_25
    pkgs.gopls
    pkgs.delve
    pkgs.ginkgo
    pkgs.golangci-lint-langserver
    pkgs.golangci-lint
    ## Node
    pkgs.nodejs_24
    pkgs.typescript-language-server
    ## Nix
    pkgs.nil
    ## Python
    pkgs.ty
    ## Shells
    pkgs.fish-lsp
    pkgs.bash-language-server
    ## HTML
    pkgs.superhtml
    pkgs.prettier
    ## Ruby
    pkgs.ruby
    pkgs.rubyPackages.solargraph
    ## CSS
    pkgs.vscode-langservers-extracted
    ## Rust
    pkgs.rustup
    ## TF
    pkgs.terraform-ls
    ## Markdown
    pkgs.markdown-oxide
    ## Java
    pkgs.jdt-language-server

    # NUR packages
    pkgs.nur.repos.charmbracelet.crush

    # Custom overlay packages
    pkgs.brush
  ];

  #
  # SERVICES
  #
  services.ollama = {
    enable = true;
  };

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
    CLOUD_ML_REGION = "global";
    ANTHROPIC_VERTEX_PROJECT_ID = "itpc-ca-8c18d68a6f";
    VERTEXAI_PROJECT = "itpc-ca-8c18d68a6f";
    VERTEXAI_LOCATION = "global";
    JIRA_URL = "https://redhat.atlassian.net";
    JIRA_EMAIL = "btroutma@redhat.com";
  };
}
