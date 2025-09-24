# Home Manager Configuration

A declarative home environment configuration using [Home Manager](https://github.com/nix-community/home-manager) and Nix Flakes.

## Overview

This configuration manages development tools, shell environment, and applications for my work as an engineer on ROSA as well as my
personal packages and configuration as a terminal-focused developer (helix editor, tmux, etc)

## Structure

```
.
├── flake.nix           # Flake configuration and inputs
├── home.nix           # Main home manager configuration
├── programs/          # Program-specific configurations
│   ├── default.nix    # Program imports and basic configs
│   └── *.nix          # Individual program configurations
├── overlay/           # Custom package overlays
│   ├── overlay.nix    # Overlay entry point
│   └── backplane.nix  # Custom ocm-backplane package
└── README.md          # This file
```

## Features

### Development Tools

- **Go Development**: Go compiler, language server (gopls), debugger (delve), testing framework (ginkgo)
- **Node.js Development**: Node.js 24, TypeScript language server
- **Python Development**: Python 3.13 with pip, ty type checker
- **Ruby Development**: Ruby with Solargraph language server
- **Nix Development**: Nix language server (nil)
- **Web Development**: HTML (superhtml), CSS language servers, Prettier formatter
- **Fish Shell**: Fish language server
- **Build Tools**: GNU Make, GCC compiler
- **Container Tools**: Podman for container management

### Red Hat/OpenShift Ecosystem

- **ROSA CLI**: Red Hat OpenShift Service on AWS command-line tool
- **OCM**: OpenShift Cluster Manager CLI
- **OpenShift CLI**: OpenShift command-line interface
- **OCM Backplane**: Custom-built backplane CLI for cluster access
- **Jira CLI**: Command-line interface for Jira
- **SAML2AWS**: AWS CLI authentication via SAML
- **Terraform**: Infrastructure as code tool

### Cloud Platforms

- **AWS CLI v2**: Amazon Web Services command-line interface
- **Google Cloud SDK**: Google Cloud Platform tools

### Editor & Shell

- **Helix**: Modern modal text editor with LSP support (configured in `programs/helix.nix`)
  - `ao` theme
  - Vi-style keybindings (jk to escape insert mode)
  - Auto-completion and formatting enabled
  - Custom statusline configuration
- **Zsh**: Shell with Oh My Zsh framework (configured in `programs/zsh.nix`)
  - `eastwood` theme
  - Git plugin enabled
  - Aliases: `hme` (home-manager edit), `hms` (home-manager switch)
- **Fish**: Modern shell with intelligent autosuggestions (configured in `programs/fish.nix`)
- **Tmux**: Terminal multiplexer with Zsh as default shell (configured in `programs/tmux.nix`)
- **Neomutt**: Terminal-based email client
- **zk**: Note-taking tool
- **SSH**: Secure shell client

### Development Utilities

- **ripgrep**: Fast text search tool
- **jq**: JSON processor
- **yq**: YAML processor
- **xclip**: X11 clipboard utility
- **asciinema**: Terminal session recorder
- **codespell**: Spell checker for code
- **sops**: Secrets management tool
- **Claude Code**: AI-powered code assistant
- **Crush**: Interactive CLI tool from Charm Bracelet

### Version Control

- **Git**: Configured with user details and main as default branch (configured in `programs/git.nix`)

## Environment Variables

- `NIXPKGS_ALLOW_UNFREE=1`: Allow unfree packages
- `CLAUDE_CODE_USE_VERTEX=1`: Configure Claude Code for Vertex AI
- `CLOUD_ML_REGION=us-east5`: Set ML region for cloud services
- `ANTHROPIC_VERTEX_PROJECT_ID`: Project ID for Anthropic Vertex integration
- `VERTEXAI_PROJECT`: Vertex AI project configuration
- `VERTEXAI_LOCATION`: Vertex AI location setting

## Installation

### Prerequisites

1. Install Nix with flakes support:
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

2. Install Home Manager:
   ```bash
   nix run home-manager/master -- init --switch
   ```

### Setup

1. Clone or copy this configuration to `~/.config/home-manager/`

2. Apply the configuration:
   ```bash
   home-manager switch --flake ~/.config/home-manager#btroutma
   ```

### Updates

Update the flake inputs and rebuild:
```bash
nix flake update ~/.config/home-manager
home-manager switch --flake ~/.config/home-manager#btroutma
```

## Customization

### Adding Packages

Add packages to the `home.packages` list in `home.nix`:
```nix
home.packages = [
  pkgs.your-package
  # ... existing packages
];
```

### Program Configuration

Program configurations are modularized in the `programs/` directory:
- Each program has its own `.nix` file for specific configuration
- `programs/default.nix` imports all program modules and enables basic programs like neomutt, zk, and ssh
- Modify individual program files to customize specific tools (helix, zsh, fish, git, tmux)
- The main `home.nix` imports the entire programs directory via `./programs`

### Custom Packages

Add custom package definitions to the `overlay/` directory and import them in `overlay.nix`.

## Aliases

- `hme`: Edit home manager configuration
- `hms`: Switch to new home manager configuration

## License

This configuration is provided as-is for personal use and reference.
