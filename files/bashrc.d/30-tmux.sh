# Tmux

ts() {
    if [[ -n "$TMUX" ]]; then
        echo "already in tmux" >&2
        return 1
    fi
    tmux new-session -A -s default
}