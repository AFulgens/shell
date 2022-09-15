#!/bin/sh

echo ""
echo "[2m[3mRegistering common aliases[0m"

# common sense
alias ls='ls -hF --color=tty'
alias ll='ls -lah'
alias duh='du --max-depth=1 -h'

# history purge = remove last history entry (useful for removing passwords and such)
# Note: first dleeting the -2 (because of auto-append, see .bash_profile); then -1 (hp, because of auto-append); then persisting
alias hp='history -d $(($HISTCMD-2)); history -d $(($HISTCMD-1)); history -w'
