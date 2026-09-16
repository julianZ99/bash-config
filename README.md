# bash-config

The main idea of this repo is to keep a functional shell setup easy to reinstall and maintain without putting too much logic into one file. For custom changes, the recommended approach is to edit scripts in `files/bashrc.d` instead of changing the main config file.

Since this is my personal config, feel free to adapt it to your own needs.

## Structure

```text
.
├── install.sh
├── files
│   ├── bashrc
│   ├── inputrc
│   └── bashrc.d
│       ├── 00-environment.sh   # prompt, editor, Bash options, and completion
│       ├── 05-history.sh       # history and timestamp formatting
│       ├── 10-alias.sh         # aliases, zoxide, and ls/grep/diff/ip
│       ├── 20-paths.sh         # PATH management with path_prepend
│       ├── 30-tmux.sh          # ts helper to create or enter tmux
│       ├── 40-python.sh        # automatic activation of local .venv
│       └── 50-custom.sh        # personal functions
```

## Install

From the repo root:

```bash
./install.sh
```

The install step:

- copies `files/bashrc` to `~/.bashrc`
- copies `files/inputrc` to `~/.inputrc`
- creates `~/.bashrc.d`
- syncs each script from `files/bashrc.d` into that directory

Before overwriting existing files, the config saves a backup with the `.bak` suffix.

## Requirements

- Bash
- `rsync`

## Customization

The scripts in `files/bashrc.d/` are grouped by what they touch:

- `00-environment.sh`: prompt, editor, shell options
- `05-history.sh`: history behavior
- `10-alias.sh`: aliases and external tools
- `20-paths.sh`: system paths
- `30-tmux.sh`: tmux shortcuts
- `40-python.sh`: local virtual environment
- `50-custom.sh`: custom functions and commands