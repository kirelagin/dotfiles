###
# !!! You have to run "autoload -U zkbd && zkbd" first
local termID=${${DISPLAY:t}:-$VENDOR-$OSTYPE}
source ~/.zkbd/$TERM-$termID

bindkey -v  # vim mode
bindkey -M viins '^x' push-line
