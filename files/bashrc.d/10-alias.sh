# Aliases

alias gitc='git clone'
alias chmodx='chmod +x'

[[ -x "$(command -v duf)" ]] && alias df=duf

# zoxide
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"

# ls command
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --group-directories-first'
    alias la='eza -a --group-directories-first'
    alias ll='eza -l --group-directories-first'
    alias lal='eza -la --group-directories-first'
    alias l='eza --group-directories-first'
    alias lt='eza -lt --group-directories-first'
    alias ltr='eza -ltr --group-directories-first'
elif ls --color=auto >/dev/null 2>&1; then
    alias ls='ls --color=auto'
    alias ll='ls -l --color=auto'
    alias la='ls -a --color=auto'
    alias lal='ls -al --color=auto'
    alias l='ls --color=auto'
    alias lt='ls -lt --color=auto'
    alias ltr='ls -ltr --color=auto'
else
    alias ls='ls -G'
    alias ll='ls -l -G'
    alias la='ls -a -G'
    alias lal='ls -al -G'
    alias l='ls -G'
    alias lt='ls -lt -G'
    alias ltr='ls -ltr -G'
fi

# grep command
alias grep='grep --color=auto'

# Diff command
alias diff='diff --color=auto'

# ip command
command -v ip >/dev/null 2>&1 && alias ip='ip -color=auto'