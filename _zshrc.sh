# 
# .zshrc
#
# this file is loaded when user logined.
# if want to be loaded whenever zsh running.
# then add to .zshenv
#
export EDITOR=vim # Editor is vim

#
# setting
#
umask 022 # default umask
setopt no_beep # kill beep

#
# history setting
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt bang_hist # history expendable whin using "!"
setopt extended_history # save registerd time
setopt share_history # share history log with onather processes
setopt hist_ignore_all_dups # no duplication 
autoload history-search-end
#
# change directrory
#
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

function cd() {
    builtin cd $@ && ls --color=auto;
}

#
# keybind
#
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey -e # key binding as emacs style

export LS_COLORS='no=00:fi=00:di=36:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:*.sh=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.aac=33:*.au=33:*.flac=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.dot=31:*.dotx=31:*.xls=31:*.xlsx=31:*.ppt=31:*.pptx=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;32:*~=01;32:*#=01;32:*.bak=01;36:*.BAK=01;36:*.old=01;36:*.OLD=01;36:*.org_archive=01;36:*.off=01;36:*.OFF=01;36:*.dist=01;36:*.DIST=01;36:*.orig=01;36:*.ORIG=01;36:*.swp=01;36:*.swo=01;36:*,v=01;36:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:'

if [ -n "$LS_COLORS" ]; then
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

function color256() {
for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
}
#
# prompt
#
#
setopt prompt_subst
setopt prompt_percent
setopt transient_rprompt

#PROMPT='%(!,[ADMIN],[%n]) at %m %(?!(^_^)/!(T_T%)?) '
PROMPT='%F{42}%(!,[ADMIN,[%n) at %m]%f %F{118}%~%f'$'\n%(?!%F{193}(^_^)/%f!(T_T%)?) '
#RPROMPT='[%~]'

# Competions
fpath=(~/src/zsh-completions/src $fpath)
#
# alias
#
alias vi=vim
alias virc="vim ~/.vimrc"
alias vish="vim +VimShell"
alias vizshrc="vim ~/.zshrc"
alias ls="ls --color=auto"
alias ll="ls -l"
alias la="ls -la"
alias l="ls"


SSHAGENT=$(which ssh-agent)


PROMPT="$PROMPT"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

#
# 関数定義群
#

# SSH AGENTを起動する
function start-ssh-agent() {
	if [ -f ~/.ssh-agent-info ]
	then
		source ~/.ssh-agent-info
	fi

	ssh-add -l > /dev/null
	if [ $? -eq 2 ]
	then
		ssh-agent > ~/.ssh-agent-info
		source ~/.ssh-agent-info
	fi
}

# 固定セッションでのtmux起動
function auto-tmux() {
	test -z "$TMUX" && (tmux -S "/tmp/tmux-$(whoami)" attach || tmux -S "/tmp/tmux-$(whoami)")
}

function zle-line-init {
	# update status line
	if [ -n "$TMUX" ]
	then
		# tmux
		# 地味 ## {{{
		#statbg="colour236"
		#statfg="colour247"
		#statl1bg="colour240"
		#statl1fg="colour231"
		#statl2bg="colour148"
		#statl2fg="colour22"
		#statr1bg="colour240"
		#statr1fg="colour247"
		#statr2bg="colour252"
		#statr2fg="colour236"
		# }}}

		statbg="colour24"
		statfg="colour117"
		statl1bg="colour31"
		statl1fg="colour231"
		statl2bg="colour231"
		statl2fg="colour23"
		statr1bg="colour31"
		statr1fg="colour117"
		statr2bg="colour117"
		statr2fg="colour23"
		tmux set -g status-bg ${statbg} > /dev/null
		tmux set -g status-fg ${statfg} > /dev/null
		statl1="#[bg=${statl1bg}, fg=${statl1fg}] #(echo $HOST) "
		statl1a="#[bg=${statbg}, fg=${statl1bg}]⮀"
		statl2="#[bg=${statl2bg}, fg=${statl2fg}] #U "
		statl2a="#[bg=${statl1bg}, fg=${statl2bg}]⮀"
		tmux set -g status-left "${statl2}${statl2a}${statl1}${statl1a}" > /dev/null
		statr1="#[bg=${statl1bg}, fg=${statl1fg}] #(tmux show-options -g prefix) "
		statr1a="#[bg=${statbg}, fg=${statr1bg}]⮂"
		statr2="#[bg=${statr2bg}, fg=${statr2fg}] %Y-%m-%d(%a) %H:%M "
		statr2a="#[bg=${statr1bg}, fg=${statr2bg}]⮂"
		tmux set -g status-right "${statr1a}${statr1}${statr2a}${statr2}" > /dev/null
	fi
}

function start-ssh-agent {
	ssh-agent > a
	source a
	ssh-add .ssh/kurari_rsa
}

# ローカルファイルの読み込み
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
