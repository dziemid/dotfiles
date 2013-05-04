export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

source ~/dotfiles/githelpers.sh

alias be="bundle exec "
alias bi="bundle install "
alias ber="bundle exec rake"
alias g="git s"
alias gp="git p"
alias gpush="git push"
alias gl="gitl"
alias gd="git diff"
alias gad="git add ."
alias gcm="git commit -m "
alias work="cd ~/work"
alias rea="cd ~/work/rea"
alias calculon="cd ~/work/rea/calculon"
alias codefun="cd ~/code_fun"

if [[ ${EUID} == 0 ]] ; then
    PS1='\[\033[01m\][ \[\033[01;31m\]\u@\h \[\033[00m\]\[\033[01m\]] \[\033[01;32m\]\w\[\033[00m\]\n\[\033[01;31m\]$\[\033[00m\]> '
else
    PS1='\[\033[01m\][ \[\033[01;34m\]\u@\h \[\033[00m\]\[\033[01m\]] \[\033[01;32m\]\w\[\033[00m\]\n\[\033[01;34m\]$\[\033[00m\]> '
fi


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="/usr/local/bin:/usr/local/heroku/bin:$PATH"
