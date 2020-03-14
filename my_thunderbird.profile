# Firejail profile for Thunderbird

noblacklist ${HOME}/.cache/thunderbird
noblacklist ${HOME}/.thunderbird

# noexec ${HOME} breaks DRM binaries.
?BROWSER_ALLOW_DRM: ignore noexec ${HOME}

include /etc/firejail/disable-common.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-exec.inc
include /etc/firejail/disable-interpreters.inc
include /etc/firejail/disable-programs.inc

blacklist /mnt
blacklist /run/media

mkdir ${HOME}/.cache/thunderbird
mkdir ${HOME}/.thunderbird
whitelist ${HOME}/.cache/thunderbird
whitelist ${HOME}/.thunderbird
whitelist ${HOME}/profil_Thunderbird
whitelist ${HOME}/téléchargements

# GTK+
whitelist ${HOME}/.gtkrc-2.0
whitelist ${HOME}/.config/gtk-3.0

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
private-dev
private-etc ca-certificates,dconf,fonts,group,gtk-2.0,gtk-3.0,hostname,hosts,ld.so.cache,localtime,machine-id,mailcap,mime.types,nsswitch.conf,passwd,pulse,resolv.conf,ssl,X11,xdg
private-tmp

noexec ${HOME}
noexec /tmp
