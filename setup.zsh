if [[ -a /etc/profile.d/nix.sh ]]
then
  source /etc/profile.d/nix.sh
  export NIX_REMOTE=daemon
fi
