TMOUT="$(( 60*10 ))";
! xset q &>/dev/null && export TMOUT;

case $( /usr/bin/tty ) in
	/dev/tty[0-9]*) export TMOUT;;
esac
