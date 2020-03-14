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
    /usr/local/bin/mpv ytdl://ytsearch:"$*"
}

# Alias
# Penser également à vérifierdans /usr/local/bin/ si des wrappers existent
# pour certains programmes (par ex. feh, mpv, tmux...)
alias ls='/usr/bin/ls --color=auto'
alias thunderbird="/usr/bin/firejail --profile=/etc/firejail/my_thunderbird.profile --dns=209.222.18.222 --dns=209.222.18.218 /usr/bin/thunderbird"
alias units="/usr/bin/units --history $HOME/.cache/.units_history"
alias wget="/usr/bin/wget --hsts-file=$HOME/.cache/.wget-hsts"
# Sur ANNA
#alias firefox="/usr/bin/firejail --profile=/etc/firejail/my_firefox.profile --dns=209.222.18.222 --dns=209.222.18.218 /usr/lib/firefox/firefox -P "default" --no-remote"
# Sur ORDIBUREAU
#alias firefox="/usr/bin/firejail --profile=/etc/firejail/my_firefox.profile --dns=209.222.18.222 --dns=209.222.18.218 /usr/lib/firefox/firefox -P "fix" --no-remote"
# Sur ORDIPORTABLE
#alias firefox="/usr/bin/firejail --profile=/etc/firejail/my_firefox.profile /usr/lib/firefox/firefox --no-remote"

# Prompt bash
PS1='[\u@\h \W]\$ '
