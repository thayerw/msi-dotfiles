
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

[ -e $HOME/.git-completion.sh ] && source $HOME/.git-completion.sh
GITSTATUS="\$(__git_ps1 \" (%s)\")"

# bash prompt
#PS1='[\u@\h \W]\$ '
#PS1='\n\[\033[0;32m\]\A \[\033[0;31m\]\u\[\033[0;34m\]@\[\033[0;35m\]\h\[\033[0;34m\]:\[\033[00;36m\]\W\[\033[0;33m\]\n$\[\033[0m\] '
# dynamic bash prompt
if [ -z "$SSH_TTY" ]; then
    if [ ${UID} -eq 0 ] ; then
        PS1="\n${RED}\u@\h ${PURPLE}\w${LIGHTGREEN}${GITSTATUS}\n${LIGHTRED}#${NIL} "
    else
       #PS1="\n${BLUE}\u@\h ${PURPLE}\w${LIGHTGREEN}${GITSTATUS}\n${LIGHTBLUE}\$${NIL} "
        PS1='\n\[\033[0;32m\]\A \[\033[0;31m\]\u\[\033[0;34m\]@\[\033[0;35m\]\h\[\033[0;34m\]:\[\033[00;36m\]\w\[\033[0;33m\]\n$\[\033[0m\] '
    fi
else
    PS1="\n${GREEN}\u@\h ${PURPLE}\w${LIGHTGREEN}${GITSTATUS}\n${LIGHTGREEN}\$${NIL} "
fi


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
[ -d $HOME/cxoffice/bin ] && export PATH=$PATH:$HOME/cxoffice/bin
[ -d /opt/local/ ] && export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export IGNOREEOF=3 # don't log out on Ctrl-D
export LANG=en_CA.UTF-8
export LC_ALL=en_CA.utf8
export LC_COLLATE=en_CA.utf8 # sort [a-Z] instead of [A-Z]
export HISTCONTROL=eraseboth # ingore duplicates and spaces (erasedups|ignoreboth|ignoredups|ignorespace)
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:ll:la:clear:exit' # don't append consecutive duplicates of these
export HISTSIZE=10000 # bash history will save N commands
export HISTFILESIZE=${HISTSIZE} # bash will remember N commands
export HISTTIMEFORMAT="[%Y-%m-%d - %H:%M:%S] "
export GREP_OPTIONS='--color=auto' # beautify grep
export OOO_FORCE_DESKTOP=gnome          # force OOo UI style to use GNOME theme
export MOZ_DISABLE_PANGO=1              # pango slows firefox
export FIREFOX_DSP=none                 # pango slows firefox
export MAIL=$HOME/mail                  # dummy path for local mail
export MAILCHECK=-1                     # don't bug me about new mail
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export MANPAGER=less

if [ -z "$DISPLAY" ]; then
    export BROWSER="links '%s' &"
else
    #export BROWSER=firefox
    export BROWSER=firefox-beta-bin
fi


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
alias pacq="pacman -Qi"
alias pacup="sudo pacman -Syu"              # sync and update
alias pacls="pacman -Ql"
alias pacin="sudo pacman -S"                # install pkg
alias pacout="sudo pacman -Rns"             # remove pkg and the deps it installed
alias vp="vim PKGBUILD"

# misc
alias mkdir="mkdir -p"
alias grep="grep -n"
alias sv="sudo vim"
alias hist="history | grep $1"              # search cmd history
alias df="df -h"                            # human-readable sizes
alias sizeof='du -sh'                       # print total size (recursively) of pwd
alias du="du -h"                            # print total size of pwd and subdirs
alias ducks="du -cksh * |sort -rn |head -10" # print top 10 largest files in pwd
alias free="free -m"                        # show sizes in MB
alias f="find | grep -i"                    # quick search
alias sps="ps aux | grep -v grep | grep"    # search and display processes by keyword
alias fixres="xrandr --size 1024x600"       # reset resolution
alias ntup="sudo /usr/bin/ntpdate time-a.nist.gov"  # update time
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""' # get xprop CLASS and NAME
alias getip="wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1"
alias myip='lynx -dump http://tnx.nl/ip'
alias psm="echo '%CPU %MEM   PID COMMAND' && ps hgaxo %cpu,%mem,pid,comm | sort -nrk1 | head -n 10 | sed -e 's/-bin//' | sed -e 's/-media-play//'"
alias timer='time read -p "Press enter to stop"'
alias bb="bashburn"
alias blankcd="wodim -v dev=/dev/cdrw -blank=fast -eject"
alias stripx="find . -type f -print0 | xargs -0 chmod a-x"
alias updatefonts='sudo fc-cache -vf'
alias t="todo.sh -d $HOME/.todo"
alias scan="sudo iwlist wlan0 scan | grep ESSID"
alias scanfull="sudo iwlist wlan0 scan"
alias nokiam="sudo mount -o rw,users,noauto,flush,quiet,noatime,dmask=000,fmask=111"
alias mp="mplayer"


# functions
# ---------

pacsearch() {
  echo -e "$(pacman -Ss $@ | sed \
  -e 's#core/.*#\\033[1;31m&\\033[1;30m#g' \
  -e 's#extra/.*#\\033[1;34m&\\033[1;30m#g' \
  -e 's#community/.*#\\033[0;32m&\\033[1;30m#g' \
  -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[1;30m#g' )"
}

# settitle - set the window title
# usage: settitle foo
function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

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

# define - fetch word defnition from google
# usage: define <word>
define() {
  lynx -dump "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" | grep -m 5 -w "*" | sed 's/;/ -/g' | cut -d- -f5 > /tmp/templookup.txt
  if [[ -s /tmp/templookup.txt ]] ;then
    until ! read response
      do
      echo "${response}"
      done < /tmp/templookup.txt
    else
      echo "Sorry $USER, I can't find the term \"${1} \""
  fi
  rm -f /tmp/templookup.txt
}

# absbuild - quickly build and upgrade a pkg from ABS
# usage: absbuild <pkgname>
absbuild() {
  ABSPATH=`find /var/abs -type d -name $1`
  mkdir -p $HOME/dev/abs/$1 || return 1
  cp -R $ABSPATH/* $HOME/dev/abs/$1
  cd $HOME/dev/abs/$1
  $EDITOR PKGBUILD
}

# absfind - quickly locate and cat an ABS PKGBUILD
# usage: absfind <pkgname>
absfind() {
  ABSPATH=`find /var/abs -type d -name $1`
  echo -e "\n ==> $ABSPATH\n"
  cat $ABSPATH/PKGBUILD
}


# send public key to remote server
# usage: sendkey <user@remotehost>
function sendkey () {
    if [ $# -eq 1 ]; then
        local key=""
        if [ -f $HOME/.ssh/id_dsa.pub ]; then
            key=$HOME/.ssh/id_dsa.pub
        elif [ -f $HOME/.ssh/id_rsa.pub ]; then
            key=$HOME/.ssh/id_rsa.pub
        else
            echo "No public key found" >&2
            return 1
        fi
        ssh $1 'cat >> $HOME/.ssh/authorized_keys' < $key
    fi
}


# load local settings
[ -e $HOME/.bash-local ] && source $HOME/.bash-local

