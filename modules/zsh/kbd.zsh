###
# To generate a new definition, run `autoload -U zkbd && zkbd`
local termID=${${DISPLAY:t}:-$VENDOR-$OSTYPE}
local kbddef=$HOME/.zkbd/$TERM-$termID
[ -f "$kbddef" ] && source "$kbddef"
unset termID kbddef

bindkey -v  # vim mode
bindkey -M viins '^x' push-line
