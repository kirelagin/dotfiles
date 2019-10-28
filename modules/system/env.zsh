expr '(' "$EDITOR" : ".*vim" ')' '=' 0 >/dev/null && {
  if command -v nvim >/dev/null; then
    EDITOR=nvim
  elif command -v vim >/dev/null; then
    EDITOR=vim
  fi
  export EDITOR
}
