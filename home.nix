{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "btroutma";
  home.homeDirectory = "/home/btroutma";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # Red Hat specific dependencies
    pkgs.rosa
    pkgs.ocm
    pkgs.awscli2

    # Claude dependencies
    pkgs.google-cloud-sdk
    pkgs.claude-code

    # General Dependencies
    pkgs.podman
    pkgs.jq
    pkgs.nil
    pkgs.xclip

    # Go dev dependencies
    pkgs.go
    pkgs.gopls
    pkgs.delve
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/btroutma/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
    SHELL = "zsh";
    NIXPKGS_ALLOW_UNFREE=1;
    CLAUDE_CODE_USE_VERTEX=1;
    CLOUD_ML_REGION = "us-east5";
    ANTHROPIC_VERTEX_PROJECT_ID = "itpc-gcp-hcm-pe-eng-claude";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "nord";
      keys.insert = {
        j = {
          k = "normal_mode";
        };
      };
      editor = {
        auto-format = true;
        auto-completion = true;
        bufferline = "always";
        statusline = {
          left = ["mode" "spinner"];
          center = ["file-name"];
          right = ["diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type"];
          separator = "|";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ./bashrc;
    profileExtra = builtins.readFile ./bash_profile;
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "half-life";
    };
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
}
