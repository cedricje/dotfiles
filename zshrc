# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit -D

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

compdef colormake=make


__git_files () {
    _wanted files expl 'local files' _files
}

screen_toogle() {
	xrandr --output HDMI1 --off
	xrandr --output HDMI1 --auto --left-of eDP1 --output eDP1 --auto --primary
}

touch_toggle() {
	SYNSTATE=$(synclient -l | grep TouchpadOff | awk '{ print $3 }')

	# change to other state
	if [ $SYNSTATE = 0 ]; then
		synclient touchpadoff=1
	elif [ $SYNSTATE = 1 ]; then
		synclient touchpadoff=0
	else
		echo "Couldn't get touchpad status from synclient"
	fi
}

mount_pc() {
	sudo sshfs -o allow_other,IdentityFile=~/.ssh/id_rsa sah5051@192.168.18.132:/ /mnt/pc
}

gittify() {
	chmod -R u+w *
	git init .
	cat << EOF > .gitignore
*.o
*.d
*.o.cmd
*.ko.cmd
*.ko
*.so
*.mod.c
EOF
	git add .
	git commit -m "Initial commit"
}



PROMPT='%F{cyan}%~$ %f'

# unsetopt EQUALS breaks perforce completion
# unsetopt EQUALS

#add some color 
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'



export P4USER=sah5051
export P4PORT=sahwp4s01.be.softathome.com:1666

alias p4set="source $HOME/scripts/p4set"
alias cm="colormake"

alias genservercfg="$HOME/scripts/genservercfg.sh"
alias spotify="spotify --force-device-scale-factor=2"

unset GNOME_KEYRING_CONTROL
