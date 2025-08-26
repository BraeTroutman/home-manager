# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

source ~/.nix-profile/etc/profile.d/hm-session-vars.sh

if [ -e /home/btroutma/.nix-profile/etc/profile.d/nix.sh ]; then . /home/btroutma/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

