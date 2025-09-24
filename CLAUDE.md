# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Home Manager configuration for a Red Hat engineer working on ROSA (Red Hat OpenShift Service on AWS). The configuration uses Nix Flakes to declaratively manage development tools, shell environment, and applications.

## Common Commands

### Home Manager Operations
```bash
# Edit the configuration
home-manager edit
# or use the alias: hme

# Apply configuration changes
home-manager switch --flake ~/.config/home-manager#btroutma
# or use the alias: hms

# Update flake inputs and rebuild
nix flake update ~/.config/home-manager
home-manager switch --flake ~/.config/home-manager#btroutma
```

### Configuration Structure Commands
```bash
# Check flake syntax
nix flake check ~/.config/home-manager

# Show flake info
nix flake show ~/.config/home-manager

# Build without switching
nix build ~/.config/home-manager#homeConfigurations.btroutma.activationPackage
```

## Architecture

### Flake Structure
- **flake.nix**: Entry point defining inputs (nixpkgs, home-manager, NUR) and the homeConfiguration output
- **home.nix**: Main configuration file containing package lists and environment variables
- **programs/**: Modular program configurations
  - **default.nix**: Program imports and config programs for which I have little custom config
  - **\*.nix**: Config for individual programs
- **overlay/**: Custom package overlays for packages not in nixpkgs
  - **overlay.nix**: Overlay entry point that imports custom packages
  - **backplane.nix**: Custom ocm-backplane package built from source

### Key Configuration Sections

#### Packages (`home.packages`)
Organized by category:
- Red Hat/OpenShift tools (rosa, ocm, openshift, ocm-backplane, terraform, jira-cli-go, saml2aws)
- Cloud platform CLIs (awscli2, google-cloud-sdk)
- Development tools (go toolchain, node.js, python, ruby, nix language servers, gcc, make)
- Utilities (jq, yq, ripgrep, xclip, asciinema, codespell, sops)
- NUR packages (crush from Charm Bracelet)

#### Programs Configuration
Programs are now modularized in the `programs/` directory:
- **Helix** (`programs/helix.nix`): Modal editor with LSP support, custom keybindings (jk to escape), ao theme
- **Zsh** (`programs/zsh.nix`): Shell with Oh My Zsh, eastwood theme, git plugin, custom aliases
- **Fish** (`programs/fish.nix`): Modern shell with intelligent autosuggestions
- **Git** (`programs/git.nix`): Configured with user details and main as default branch
- **Tmux** (`programs/tmux.nix`): Terminal multiplexer with zsh as default shell
- **Basic Programs** (`programs/default.nix`): Enables neomutt, zk, ssh, and home-manager

#### Environment Variables
Key variables for Red Hat/cloud development:
- `CLAUDE_CODE_USE_VERTEX=1`: Configure Claude Code for Vertex AI
- `CLOUD_ML_REGION=us-east5`: ML region for cloud services  
- `ANTHROPIC_VERTEX_PROJECT_ID`: Project ID for Anthropic Vertex integration
- `VERTEXAI_PROJECT`: Vertex AI project configuration
- `VERTEXAI_LOCATION`: Vertex AI location setting
- `NIXPKGS_ALLOW_UNFREE=1`: Allow unfree packages

### Custom Package Management

To add custom packages:
1. Create package definition in `overlay/` directory
2. Import in `overlay/overlay.nix`
3. Reference in `home.packages`

Example: The `ocm-backplane` package is built from a specific Git commit using `buildGoModule`.

### Program Configuration Management

To modify program configurations:
1. Edit the specific program file in `programs/` directory
2. For new programs, add configuration to appropriate existing file or create new file
3. Import new program files in `programs/default.nix`
4. The main `home.nix` automatically imports all programs via `./programs`

## Development Workflow

1. Edit configuration files:
   - Package changes: edit `home.nix`
   - Program-specific changes: edit files in `programs/` directory
   - Custom packages: edit files in `overlay/` directory
2. Test with `home-manager switch --flake ~/.config/home-manager#btroutma`
3. Commit changes to version control
4. For updates, use `nix flake update` to update inputs, then rebuild

## Important Notes

- Configuration targets user `btroutma` specifically in the flake outputs
- Uses nixos-unstable channel for latest packages
- Includes NUR (Nix User Repository) for additional packages like Crush
- Allows unfree packages (needed for some proprietary tools)
- Custom overlay provides packages not available in standard nixpkgs
- Program configurations are modularized for better organization and maintainability
- Environment is optimized for Red Hat OpenShift/ROSA development workflows
