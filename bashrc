#
# ~/.bashrc
#

# Ne rien faire si le mode n'est pas interactif
[[ $- != *i* ]] && return

# Ne pas activer le gel de OUTPUT avec Ctrl-S (sortie possible avec Ctrl-Q)
stty -ixon

# Utiliser Ctrl-Backspace au lieu de Ctrl-W pour supprimer le mot précédent
stty werase 

# Utiliser Ctrl-L au lieu de Ctrl-V pour afficher les caractères de contrôle
stty lnext 

# Ne pas conserver d'historique pour la fonction less (~/.lesshst)
export LESSHISTFILE=-

# Supprimer les guillemets des ls
export QUOTING_STYLE=literal

# Respecter la spécification XDG pour certaines applications
# (https://wiki.archlinux.org/index.php/XDG_Base_Directory_support)
# (voir aussi ~/.xinitrc)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# Éditeur (pour sudo -e)
export EDITOR=/usr/bin/nvim

# tmux
if command -v tmux >/dev/null 2>&1 && [ "${DISPLAY}" ]; then
        if [ -z "$TMUX" ]; then
            exec /usr/local/bin/tmux
        fi
fi

# Reparamétrer C-w pour le même comportement que dans vi (ou Vim) :
# les caractères spéciaux servent de séparateur en plus de l'espace
set -o vi

# Alias
# Penser également à vérifier dans /usr/local/bin/ si des wrappers existent
# pour certains programmes (par ex. tmux...)
alias egrep="/usr/bin/egrep --color=auto"
alias fgrep="/usr/bin/fgrep --color=auto"
alias grep="/usr/bin/grep --color=auto"
alias ls="/usr/bin/ls --color=auto"
alias thunderbird="/usr/bin/firejail --profile=/etc/firejail/my_thunderbird.profile /usr/bin/thunderbird"
alias units="/usr/bin/units --history $HOME/.cache/.units_history"
alias vim="/usr/bin/nvim"
alias vimdiff="/usr/bin/nvim -d"
alias wget="/usr/bin/wget --hsts-file=$HOME/.cache/.wget-hsts"

# Prompt bash
PS1='[\u@\h \W]\$ '
