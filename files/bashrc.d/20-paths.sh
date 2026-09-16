# Paths

path_prepend() {
    [[ -d "$1" ]] || return
    [[ ":$PATH:" == *":$1:"* ]] && return
    PATH="$1:$PATH"
}

path_prepend /opt/bin
path_prepend /usr/local/bin
path_prepend /usr/local/sbin
path_prepend "$HOME/.local/share/yabridge"
path_prepend "$HOME/.opencode/bin"
path_prepend "$HOME/.local/bin"

export PATH