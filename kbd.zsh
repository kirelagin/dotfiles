###
# !!! You have to run "autoload -U zkbd && zkbd" first
source ~/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE}

bindkey -v  # vim mode
bindkey -M viins '^x' push-line
