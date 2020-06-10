# Firejail profile for Mozilla Firefox

noblacklist ${HOME}/.cache/mozilla
noblacklist ${HOME}/.mozilla

# noexec ${HOME} breaks DRM binaries.
?BROWSER_ALLOW_DRM: ignore noexec ${HOME}

include /etc/firejail/disable-common.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-exec.inc
include /etc/firejail/disable-interpreters.inc
include /etc/firejail/disable-programs.inc

blacklist /mnt
blacklist /run/media

mkdir ${HOME}/.cache/mozilla/firefox
mkdir ${HOME}/.mozilla
whitelist ${HOME}/.cache/mozilla/firefox
whitelist ${HOME}/.mozilla
whitelist ${HOME}/téléchargements
whitelist ${HOME}/.XCompose
whitelist ${HOME}/.config/mimeapps.list
whitelist ${HOME}/.config/user-dirs.dirs
read-only ${HOME}/.config/user-dirs.dirs
# À recopier et modifier avec les noms corrects des profils !
# Une instruction pour chaque profil.
# Exemple : whitelist ${HOME}/profils_Firefox/default
#whitelist ${HOME}/profils_Firefox/nom_utilisateur

# dconf
mkdir ${HOME}/.config/dconf
whitelist ${HOME}/.config/dconf

# fonts
whitelist ${HOME}/.cache/fontconfig

# GTK+
whitelist ${HOME}/.config/gtk-3.0

# common /var whitelist
whitelist /var/lib/dbus
whitelist /var/cache/fontconfig
whitelist /var/tmp
whitelist /var/run
whitelist /var/lock

apparmor
caps.drop all
machine-id
netfilter
nodbus
nodvd
nogroups
nonewprivs
noroot
notv
?BROWSER_DISABLE_U2F: nou2f
protocol unix,inet,inet6,netlink
seccomp !chroot
#seccomp.drop @clock,@cpu-emulation,@debug,@module,@obsolete,@raw-io,@reboot,@resources,@swap,acct,add_key,bpf,fanotify_init,io_cancel,io_destroy,io_getevents,io_setup,io_submit,ioprio_set,kcmp,keyctl,mount,name_to_handle_at,nfsservctl,ni_syscall,open_by_handle_at,personality,pivot_root,process_vm_readv,ptrace,remap_file_pages,request_key,setdomainname,sethostname,syslog,umount,umount2,userfaultfd,vhangup,vmsplice
shell none

disable-mnt
private-bin bash,dbus-launch,dbus-send,env,firefox,sh,which
private-dev
private-etc ca-certificates,dconf,fonts,group,gtk-2.0,gtk-3.0,hostname,hosts,ld.so.cache,localtime,machine-id,mailcap,mime.types,nsswitch.conf,passwd,pulse,resolv.conf,ssl,X11,xdg
private-tmp
