HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000

setopt HIST_IGNORE_ALL_DUPS 
setopt HIST_IGNORE_SPACE    # do not record events starting with space
setopt HIST_REDUCE_BLANKS   # remove unnecessary spaces before storing a line
#setopt HIST_VERIFY          # confirm command before executing after history expansion
setopt INC_APPEND_HISTORY   # append event to histfile right after executing
setopt SHARE_HISTORY        # share history with other running instances of zsh (implies INC_APPEND_HISTORY)
