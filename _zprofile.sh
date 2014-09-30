#
#
#
for i in /etc/profile.d/*.sh
do
	[ -r $i ] && source $i
done

[ -f ~/.zsh/local/.zprofile.sh ] && ~/.zsh/local/.zprofile.sh

