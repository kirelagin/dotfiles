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

bindkey -v  # vim mode

# Show full directory path and history event ID
PS1='%B%F{green}%n@%m%k %B%F{blue}%~ %B%F{black}[%h]%(?..%B%F{red}<%?>)%B%F{blue}%# %b%f%k'
