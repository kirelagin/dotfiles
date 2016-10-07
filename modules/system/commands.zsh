alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -v -al'
if [ $(uname) = "Darwin" ]; then
  alias ls='ls -G'
  export LSCOLORS='ExFxCxDxBxEgEdAbAgAcAd'
else
  alias ls='ls -v --color=auto'
fi
alias man='LANG=C man'
alias hg='LANG=C hg'
alias gvim='gvim -f'
