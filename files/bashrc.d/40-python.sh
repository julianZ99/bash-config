# Python

export UV_LINK_MODE=copy

# Activate local venv if present in the current directory
if [[ -z "${VIRTUAL_ENV:-}" ]] && [[ -f .venv/bin/activate ]]; then
    source .venv/bin/activate
fi