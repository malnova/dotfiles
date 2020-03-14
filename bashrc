#
# ~/.bashrc
#

# Transparence de la fenêtre
sleep .05; transset-df -a 0.85 > /dev/null 2>&1

# Ne pas activer le gel de OUTPUT avec Ctrl-S (sortie possible avec Ctrl-Q)
stty -ixon

# Ne pas conserver d'historique pour la fonction less (~/.lesshst)
export LESSHISTFILE=-

# Supprimer les guillemets des ls
export QUOTING_STYLE=literal

# Respecter la spécification XDG pour certaines applications
# (voir aussi ~/.xinitrc)
export VIMINIT=":source $HOME"/.config/vim/vimrc

# Ne rien faire si le mode n'est pas interactif
[[ $- != *i* ]] && return

# tmux
if [[ $DISPLAY ]]; then
    if /usr/bin/which tmux >/dev/null 2>&1; then
        test -z "$TMUX" && exec /usr/local/bin/tmux
    fi
fi

# Fonctions
# Lancer une recherche sur YouTube depuis la ligne de commande avec mpv
function mpvs {
    mpv ytdl://ytsearch:"$*"
}

# Alias
# Penser également à vérifier dans /usr/local/bin/ si des wrappers existent
# pour certains programmes (par ex. feh, tmux...)
alias ls='/usr/bin/ls --color=auto'
alias thunderbird="/usr/bin/firejail --profile=/etc/firejail/my_thunderbird.profile /usr/bin/thunderbird"
alias units="/usr/bin/units --history $HOME/.cache/.units_history"
alias wget="/usr/bin/wget --hsts-file=$HOME/.cache/.wget-hsts"

# Prompt bash
PS1='[\u@\h \W]\$ '
