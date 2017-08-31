if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ls='ls --color'
alias ll='ls -al --color'
alias la='ls -a --color'
alias grepc='grep -iIRn --color=always'

alias man='nocorrect man'
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'

alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias i3config='vim ~/.config/i3/config'
alias tmuxconf='vim ~/.tmux.conf'
alias open=xdg-open

# env
export LSCOLORS=exfxcxdxbxegedabagacad
export EDITOR=vim

setopt autocd
setopt long_list_jobs

export CLICOLOR=1
setopt no_beep
setopt multios
setopt CDABLE_VARS

autoload -U url-quote-magic
zle -N self-insert url-quote-magic
setopt correct_all

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end

# Completions
autoload -Uz compinit
compinit -d ~/.dumpfile
zstyle ':completion:*' list-colors "di=34:ln=35:so=32:pi=33:ex=31:bd=34:cd=34:su=0:sg=0:tw=0:ow=0:"

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

if [ "x$COMPLETION_WAITING_DOTS" = "xtrue" ]; then
  expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache on

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs

# ... unless we really want to.
zstyle '*' single-ignored show

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh/history
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt EXTENDED_HISTORY


# prompt
setopt prompt_subst
setopt promptsubst
setopt promptpercent

autoload colors; colors;

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# local user_host='%{$fg[green]%}%n@%m%{$reset_color%}'
local user_host='%{$fg[green]%}%n%{$reset_color%}'
local current_dir='%{$fg[blue]%}%~%{$reset_color%}'

local git_branch='$(git_prompt_info)%{$reset_color%}'

RPROMPT="[%{$fg[green]%}%@%{$reset_color%}] ${return_code}%{$reset_color%}"
PROMPT="┌─[${user_host}]—[${current_dir}]${git_branch}
└─%B%b "

ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Git Prompt
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "[%{$fg[yellow]%}${ref#refs/heads/}%{$reset_color%}]"
}

local user_host='%{$fg[yellow]%}%n@%m%{$reset_color%}'
local current_dir='%{$fg[green]%}%~%{$reset_color%}'
RPROMPT="[%{$fg[yellow]%}%@%{$reset_color%}] ${return_code}%{$reset_color%}"
PROMPT="
┌─[${current_dir}]${git_branch}
└─ %B%b"

# bindkey -v
bindkey '^r' history-incremental-search-backward
bindkey '^b' beginning-of-line
bindkey '^e' end-of-line

reset_widget() { tput reset; builtin zle .redisplay; }
zle -N reset_widget
bindkey '^k' reset_widget

# PATH="/home/grzesio/perl5/bin${PATH:+:${PATH}}"; export PATH;
# PERL5LIB="/home/grzesio/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
# PERL_LOCAL_LIB_ROOT="/home/grzesio/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
# PERL_MB_OPT="--install_base \"/home/grzesio/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/home/grzesio/perl5"; export PERL_MM_OPT;

PATH=$PATH:/var/fpwork/kogrzego/mfo-workspace/repo/misc-utils
alias config='/usr/bin/git --git-dir=/home/grzesio/.cfg/ --work-tree=/home/grzesio'
