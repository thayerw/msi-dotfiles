
# ~/.bashrc
# thayer williams - http://cinderwick.ca


# Check for an interactive session
[ -z "$PS1" ] && return


# prompt colours
RED='\[\033[0;31m\]'
LIGHTRED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
LIGHTGREEN='\[\033[1;32m\]'
YELLOW='\[\033[0;33m\]'
LIGHTYELLOW='\[\033[1;33m\]'
BLUE='\[\033[0;34m\]'
LIGHTBLUE='\[\033[1;34m\]'
PURPLE='\[\033[0;35m\]'
LIGHTPURPLE='\[\033[1;35m\]'
CYAN='\[\033[0;36m\]'
LIGHTCYAN='\[\033[1;36m\]'
WHITE='\[\033[1;37m\]'
LIGHTGREY='\[\033[0;37m\]'
BLACK='\[\033[1;30m\]'
DARKGREY='\[\033[0;30m\]'
NIL='\[\033[00m\]'

# bash prompt
#PS1='[\u@\h \W]\$ '
PS1="\n${GREEN}\A ${RED}\u${DARKGREY}@${PURPLE}\h${DARKGREY}:${LIGHTBLUE}\w\n${YELLOW}\$${NIL} "


# sudo bash completion and advanced completion
complete -cf sudo
[ -e /etc/bash_completion ] && source /etc/bash_completion


# disable ^s/^q flow control
stty -ixon
stty -ixoff


# pretty dir listings
[ -e $HOME/.dircolors ] && eval $(dircolors -b $HOME/.dircolors)


# bash options
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s histappend # append to the history file
shopt -s no_empty_cmd_completion # don't search completions in PATH on an empty line


# linux console colors
if [ "$TERM" = "linux" ]; then
	#legend:  blk    red    grn    yel    blu    mag    cya    wht
	vimbrant=(222222 f92672 82b414 fd971f 56c2d6 8c54fe 465457 ccccc6
              505354 ff5995 b6e354 feed6c 8cedff 9e6ffe 899ca1 f8f8f2)
	lightr=(eeeeee ff0000 008700 af5f00 000087 870087 0087af 555555
            222222 ff005f 00af00 ff8700 0000ff af00d7 00afd7 ffffff)
	for n in $(seq 0 15); do
		printf '\e]P%x%s' $n ${vimbrant[$n]}
	done
	clear; unset vimbrant; unset lightr
fi


# exports
# -------

[ -d $HOME/bin ] && export PATH=$HOME/bin:$PATH
export LC_ALL=en_CA.utf8
export HISTCONTROL=eraseboth # ingore duplicates and spaces (erasedups|ignoreboth|ignoredups|ignorespace)
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:ll:la:clear:exit' # don't append consecutive duplicates of these
export HISTSIZE=10000 # bash history will save N commands
export HISTFILESIZE=${HISTSIZE} # bash will remember N commands
export HISTTIMEFORMAT="[%Y-%m-%d - %H:%M:%S] "
export GREP_OPTIONS='--color=auto' # beautify grep
export EDITOR=vim
export http_proxy=http://localhost:8118/

# man pager colors
export GROFF_NO_SGR=1 # output ANSI color escape sequences in raw form
export LESS_TERMCAP_mb=$'\E[0;31m' # blinking
export LESS_TERMCAP_md=$'\E[1;34m' # bold used for headings
export LESS_TERMCAP_us=$'\E[1;32m' # underline used for paths,keywords
export LESS_TERMCAP_so=$'\E[41;1;37m' # standout used for statusbar/search
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_me=$'\E[0m' # end all modes like so, us, mb, md and mr


# aliases
# -------

alias ls="ls -hF --group-directories-first --color=auto"
alias ll="ls -l"
alias la="ls -lA"
alias dir="ls -1"
alias ..="cd .."
alias ...="cd ../.."

# archlinux aliases
alias pac="pacsearch"                       # colorize pacman (pacs)
alias pacs="pacman -Sl | cut -d' ' -f2 | grep " # search pkgname by keyword
alias pacq="pacman -Qi"                     # pkg info
alias pacup="sudo pacman -Syu"              # sync and update
alias pacls="pacman -Ql"                    # pkg filelist
alias pacin="sudo pacman -S"                # install pkg
alias pacout="sudo pacman -Rns"             # remove pkg and the deps it installed
alias vp="vim PKGBUILD"

# misc
alias mkdir="mkdir -p"
alias grep="grep -n"
alias sv="sudo vim"
alias hist="history | grep $1"              # search cmd history
alias df="df -h"                            # human-readable sizes
alias du="du -h"                            # print total size of pwd and subdirs
alias ducks="du -cksh * |sort -rn |head -10" # print top 10 largest files in pwd
alias free="free -m"                        # show sizes in MB
alias f="find | grep -i"                    # quick search
alias sps="ps aux | grep -v grep | grep"    # search and display processes by keyword
alias fixres="xrandr --size 1024x600"       # reset resolution
alias ntup="sudo /usr/bin/ntpdate time-a.nist.gov"  # update time
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""' # get xprop CLASS and NAME
alias getip='lynx -dump http://tnx.nl/ip'
alias psm="echo '%CPU %MEM   PID COMMAND' && ps hgaxo %cpu,%mem,pid,comm | sort -nrk1 | head -n 10 | sed -e 's/-bin//' | sed -e 's/-media-play//'"
alias blankcd="wodim -v dev=/dev/cdrw -blank=fast -eject"


# functions
# ---------

pacsearch() {
	echo -e "$(pacman -Ss $@ | sed \
	-e 's#core/.*#\\033[1;31m&\\033[1;30m#g' \
	-e 's#extra/.*#\\033[1;34m&\\033[1;30m#g' \
	-e 's#community/.*#\\033[0;32m&\\033[1;30m#g' \
	-e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[1;30m#g' )"
}

# extract - archive extractor
# usage: extract <file>
extract() {
	if [ -f "$1" ] ; then
		case "$1" in
			*.tar.bz2) tar xvjf "$1" ;;
			*.tar.gz) tar xvzf "$1" ;;
			*.bz2) bunzip2 "$1" ;;
			*.rar) unrar x "$1" ;;
			*.gz) gunzip "$1" ;;
			*.tar) tar xvf "$1" ;;
			*.tbz2) tar xvjf "$1" ;;
			*.tgz) tar xvzf "$1" ;;
			*.zip) unzip "$1" ;;
			*.Z) uncompress "$1" ;;
			*.7z) 7z x "$1" ;;
			*)
		echo "$1 is not a valid archive"
		return 1
		;;
		esac
	else
		echo "$1 is not a valid file"
		return 1
	fi
	return 0
}


# load local settings (private stuff, etc.)
[ -e $HOME/.bash-local ] && source $HOME/.bash-local
