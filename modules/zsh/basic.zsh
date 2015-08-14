# Directory stack
##################

DIRSTACKSIZE=10
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS


###
########################
###

setopt NO_CLOBBER           # do not allow > to overwrite files and >> to create new ones
setopt HIST_ALLOW_CLOBBER   # rewrite a line before storing so that it is not subject to NO_CLOBBER
setopt CORRECT              # correct invalid command names
#setopt EXTENDED_GLOB        # regexps in globs


# Set window title
###################

precmd() {
  print -Pn "\e]2;%n@%m: %~\a"
}
