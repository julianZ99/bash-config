# History

export HISTFILE="$HOME/.bash_history"
export HISTSIZE=50000
export HISTFILESIZE=100000
export HISTIGNORE="&:[ ]*:exit"

export HISTCONTROL=ignoreboth:erasedups

shopt -s histappend
shopt -s cmdhist

export HISTTIMEFORMAT='%F %T '