#!/usr/bin/env bash
# Be strict
set -eEu pipefail

REPO_URL="https://github.com/julianZ99/bash-config"
REPO_BRANCH="main"

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

# Resolve the directory where this script lives.
# When running via `curl | bash`, $0 is "bash" and there are no local files,
# so we fetch the repo from GitHub into a temporary directory instead.
SCRIPT_SRC_DIR="$PWD"
if [ -f "$0" ]; then
    SCRIPT_SRC_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
fi
SCRIPT_DIR_CONFIGS="$SCRIPT_SRC_DIR/files"

if [ ! -d "$SCRIPT_DIR_CONFIGS" ]; then
    info "Fetching $REPO_URL ($REPO_BRANCH)"
    TMP_DIR="$(mktemp -d)"
    curl -fsSL "$REPO_URL/archive/refs/heads/$REPO_BRANCH.tar.gz" | tar -xz -C "$TMP_DIR"
    SCRIPT_DIR_CONFIGS="$TMP_DIR/bash-config-$REPO_BRANCH/files"
    SRC_CLEANUP="$TMP_DIR"
fi

copy "$SCRIPT_DIR_CONFIGS/bashrc" "$HOME/.bashrc"

copy "$SCRIPT_DIR_CONFIGS/inputrc" "$HOME/.inputrc"

info "Creating $HOME/.bashrc.d dir"
mkdir -p "$HOME/.bashrc.d"

copy "$SCRIPT_DIR_CONFIGS/bashrc.d/" "$HOME/.bashrc.d/"

if [ -n "${SRC_CLEANUP:-}" ]; then
    rm -rf "$SRC_CLEANUP"
fi