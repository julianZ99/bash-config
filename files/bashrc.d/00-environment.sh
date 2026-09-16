# Environment

# Bash cmdline
__git_branch() {
    if [ -n "$(command -v __git_ps1)" ]; then
        __git_ps1 " (%s)"
    elif command -v git >/dev/null 2>&1; then
        local b
        b=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) && printf ' (%s)' "$b"
    fi
}

PS1='\[\e[1;32m\]\u@\h\[\e[0m\]: \[\e[1;34m\]\w\[\e[0m\]\[\e[1;33m\]$(__git_branch)\[\e[0m\] \[\e[1;37m\]\$\[\e[0m\] '

# Editor
export EDITOR='code --wait'
export VISUAL='code --wait'

# Remove blinking and red background for non-existent files in Readline/ls
if [[ -n "${LS_COLORS:-}" ]]; then
    export LS_COLORS="$(echo "$LS_COLORS" | sed 's/mi=[^:]*/mi=00/')"
fi

# Expand ** recursive
shopt -s globstar

# Auto cd
shopt -s autocd 2>/dev/null || true

# Update dimensions
shopt -s checkwinsize

# Load bash-completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# Disable freeze terminal using C-s
[[ -t 0 ]] && stty -ixon 2>/dev/null || true