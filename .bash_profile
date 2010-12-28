#
# ~/.bash_profile
# Thayer Williams - http://cinderwick.ca
#

# start keychain, feed it keys and source the results
#export SSH_ASKPASS=/usr/local/bin/gtk-led-askpass
export SSH_ASKPASS=/usr/lib/openssh/x11-ssh-askpass
/usr/bin/keychain -Q -q ~/.ssh/id_rsa < /dev/null
[ -f $HOME/.keychain/$HOSTNAME-sh ] && source $HOME/.keychain/$HOSTNAME-sh

# source bashrc
[ -f .bashrc ] && source $HOME/.bashrc

# auto startx if logging in at VC/1
if [ -z "$DISPLAY" ] && [ $(tty) = /dev/tty1 ]; then
    xinit >& ~/.myXLog
    logout
#elif [[ $(tty) != /dev/tty7 ]]; then
    #tmux attach -t dublin 
fi

