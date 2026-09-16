#!/usr/bin/env bash
# Be strict
set -eEu pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR_CONFIGS="$SCRIPT_DIR/files"

ok() {
    echo -e "\e[0;32m---> Success\e[0m"
}

info() {
    echo -e "\e[0;36m---> $@\e[0m"
}

copy() {
    local src="$1"
    local dst="$2"

    if [ -d "$src" ]; then
        src="${src%/}/"
        dst="${dst%/}/"

        if [ -d "$dst" ]; then
            info "Making a backup of $dst"
            rsync -av --delete -- "$dst" "${dst%/}.bak/"
            ok
        fi
    elif [ -f "$dst" ]; then
        info "Making a backup of $dst"
        rsync -av -- "$dst" "$dst.bak"
        ok
    fi

    info "Copying $src to $dst"
    rsync -av -- "$src" "$dst"
    ok
}

copy "$SCRIPT_DIR_CONFIGS/bashrc" "$HOME/.bashrc"

copy "$SCRIPT_DIR_CONFIGS/inputrc" "$HOME/.inputrc"

info "Creating $HOME/.bashrc.d dir"
mkdir -p "$HOME/.bashrc.d"

copy "$SCRIPT_DIR_CONFIGS/bashrc.d/" "$HOME/.bashrc.d/"