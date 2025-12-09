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
    pkgs.ocm
    pkgs.awscli2
    pkgs.openshift
    pkgs.ocm-backplane
    pkgs.terraform
    pkgs.jira-cli-go
    pkgs.saml2aws
    pkgs.stern
    pkgs.gabi-cli

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
    pkgs.go_1_24
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
    pkgs.python313Packages.pip
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
    ## Haskell
    pkgs.haskell-language-server
    pkgs.ghc
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
}
