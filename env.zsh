if (( $+commands[nix-env] ))
then
  export NIX_REMOTE=daemon

  export FPATH="$HOME/.nix-profile/share/zsh/site-functions:$FPATH"
  export MANPATH="$HOME/.nix-profile/share/man:$MANPATH"
fi
