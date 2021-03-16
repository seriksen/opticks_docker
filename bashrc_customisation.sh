export PS1='\[\033[02;32m\]\u@optix_docker:\[\033[02;34m\]\w\$\[\033[00m\] '

export LD_LIBRARY_PATH=/usr/lib64:/usr/lib:${LD_LIRARY_PATH}

alias ls='ls --color=auto'
alias vim='vi'
alias la='ls -a --color=auto'
alias ll='la -l -h --color=auto'
alias ..='cd ..; ls'

start_desktop() {
  /opt/TurboVNC/bin/vncserver -vgl -wm xfce4-session
}

kill_desktop() {
  filename=$(basename ${HOME}/.vnc/*.log)
  filename=${filename%.*}
  desktop=${filename#*:}
  /opt/TurboVNC/bin/vncserver -kill :${desktop}
}
