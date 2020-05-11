# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi

mesg n

alias vi='nvim'
alias ls='ls --color=auto'

export VISUAL=vim
export EDITOR=vim
export SVN_EDITOR=vim
export CSCOPE_EDITOR=vim
export TMOUT=0

#
# Colorize...
#  GREP_COLOR='0;fore;back'
#       Black	    30	               40
#       Red	        31	               41
#       Green	    32	               42
#       Yellow	    33	               43
#       Blue	    34	               44
#       Magenta	    35	               45
#       Cyan	    36	               46
#       White	    37	               47
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='0;36'

PS1='\[\033[0;38m\]${PSTAG}\[\033[0;35m\]${PROJ_DIR}@\[\033[0;31m\]\h \[\033[0;32m\]\w]\$\[\033[0;38m\] '
