{ pkgs_, pkgs }:
with pkgs;

let
  haskellEnv = haskellPackages.ghcWithPackages
    (hp: with hp; [
      base-unicode-symbols
      exceptions
      hashable
      html
      HTTP
      HUnit
      MonadRandom
      mtl
      network
      parsec
      QuickCheck
      random
      regex-base
      regex-compat
      regex-posix
      text
      transformers
      unordered-containers
      vector
      zlib

      alex
      comonad
#      criterion
      ghc
#      haddock
      happy
      lens

#      Agda-executable
#      xmonad xmonad-contrib xmonad-extras
    ]);
in
{
  name = "*";
  userPackages = [
#                    gphoto2
#                    openjdk

         androidenv.platformTools
                    biber
#                    cabal2nix
                    catdoc
                    ctags
                    fswatch
    haskellPackages.ghc-mod
        gitAndTools.git
                    gnupg
                    haskellEnv
    haskellPackages.hdevtools
                    htop
#osx:runtime:ca root not found        gitAndTools.hub
#                    maven
#                    mutt-with-sidebar
                    ncdu
                    neovim
                    nixUnstable
    haskellPackages.pandoc
#tmp    haskellPackages.pandoc-citeproc
                    python3
                    rhc
                    socat
];}
