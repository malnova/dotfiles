#
# ~/.bashrc
#

# Ne pas activer le gel de OUTPUT avec Ctrl-S (sortie possible avec Ctrl-Q)
stty -ixon

# Ne pas conserver d'historique pour la fonction less (~/.lesshst)
export LESSHISTFILE=-

# Supprimer les guillemets des ls
export QUOTING_STYLE=literal

# Respecter la spécification XDG pour certaines applications
# (https://wiki.archlinux.org/index.php/XDG_Base_Directory_support)
# (voir aussi ~/.xinitrc)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# Éditeur (pour sudo -e)
export EDITOR=nvim

# Ne rien faire si le mode n'est pas interactif
[[ $- != *i* ]] && return

# tmux
if [[ $DISPLAY ]]; then
    if /usr/bin/which tmux >/dev/null 2>&1; then
        if [ -z "$TMUX" ]; then
            # Transparence de la fenêtre (uniquement dans une nouvelle
            # fenêtre ; ne pas réactiver la transparence dans un split)
            sleep .05; transset-df -a 0.85 > /dev/null 2>&1
            exec /usr/local/bin/tmux
        fi
    fi
fi

# Reparamétrer C-w pour le même comportement que dans vi (ou Vim) :
# les caractères spéciaux servent de séparateur en plus de l'espace
set -o vi

# Alias
# Penser également à vérifier dans /usr/local/bin/ si des wrappers existent
# pour certains programmes (par ex. feh, tmux...)
alias ls="/usr/bin/ls --color=auto"
alias thunderbird="/usr/bin/firejail --profile=/etc/firejail/my_thunderbird.profile /usr/bin/thunderbird"
alias units="/usr/bin/units --history $HOME/.cache/.units_history"
alias vim="/usr/bin/nvim"
alias vimdiff="/usr/bin/nvim -d"
alias wget="/usr/bin/wget --hsts-file=$HOME/.cache/.wget-hsts"

# Prompt bash
PS1='[\u@\h \W]\$ '
