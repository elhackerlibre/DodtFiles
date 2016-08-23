#!/bin/bash

#echo -e '\n\e[01;30m ▓▓\e[0;30m ▓▓\e[01;31m ▓▓\e[0;31m ▓▓\e[01;32m ▓▓\e[0;32m ▓▓\e[01;33m ▓▓\e[0;33m ▓▓\e[01;34m ▓▓\e[0;34m ▓▓\e[01;35m ▓▓\e[0;35m ▓▓\e[01;36m ▓▓\e[0;36m ▓▓\e[01;37m ▓▓\e[0;37m ▓▓\n'
#echo -e '\n\e[01;30m ▚ \e[0;30m ▞ \e[01;31m ▚ \e[0;31m ▞ \e[01;32m ▚ \e[0;32m ▞ \e[01;33m ▚ \e[0;33m ▞ \e[01;34m ▚ \e[0;34m ▞ \e[01;35m ▚ \e[0;35m ▞ \e[01;36m ▚ \e[0;36m ▞ \e[01;37m ▚ \e[0;37m ▞ \n'

c00=$'\e[0;30m'
c01=$'\e[0;31m'
c02=$'\e[0;32m'
c03=$'\e[0;33m'
c04=$'\e[0;34m'
c05=$'\e[0;35m'
c06=$'\e[0;36m'
c07=$'\e[0;37m'
c08=$'\e[1;30m'
c09=$'\e[1;31m'
c10=$'\e[1;32m'
c11=$'\e[1;33m'
c12=$'\e[1;34m'
c13=$'\e[1;35m'
c14=$'\e[1;36m'
c15=$'\e[1;37m'

f0=$'\e[1;31m'
f1=$'\e[1;37m'
f2=$'\e[0;37m'

kernel=$(uname -rmo)
system=$(sed 's/\s*[\(\\]\+.*$//' /etc/issue)

if [ -n "$DISPLAY" ]; then
    WM=$(xprop -root _NET_SUPPORTING_WM_CHECK)
    wmname=$(xprop -id ${WM//* } _NET_WM_NAME | sed -re 's/.*= "(.*)"/\1/')
    fon=$(xrdb -query | sed -n 's/^UR.*\*font:\s*//p')
    if [[ $fon =~ "xft" ]]; then
        termfn=$(echo $fon | awk -F ':' '{print $2}')
    else
        termfn=$(echo $fon | sed -re 's/^-\w+-(\w+)-.*/\1/')
    fi
    systfn=$(sed -n 's/^.*font.*"\(.*\)".*$/\1/p' ~/.gtkrc-2.0)
    gtktheme=$(sed -n 's/^gtk-theme.*"\(.*\)".*$/\1/p' ~/.gtkrc-2.0)
    icons=$(sed -n 's/^.*icon.*"\(.*\)".*$/\1/p' ~/.gtkrc-2.0)
else
    wmname="none"
    termfn="none"
    systfn="none"
fi

pkgnum=$(pacman -Q | wc -l)
birthd=$(sed -n '1s/^\[\([0-9-]*\).*$/\1/p' /var/log/pacman.log | tr - .)

cat << EOF

    ${c00}▉▉  | ${f1}OS ${f0}........... $f2$system
    ${c08}  ▉▉| ${f1}name ${f0}......... $f2$HOSTNAME
    ${c01}▉▉  | ${f1}birth day${f0}..... $f2$birthd
    ${c09}  ▉▉| ${f1}packages ${f0}..... $f2$pkgnum
    ${c02}▉▉  |
    ${c10}  ▉▉| ${f1}kernel ${f0}....... $f2$kernel
    ${c03}▉▉  | ${f1}wm ${f0}........... $f2$wmname
    ${c11}  ▉▉| ${f1}shell ${f0}........ $f2$SHELL
    ${c04}▉▉  |
    ${c12}  ▉▉| ${f1}terminal ${f0}..... $f2$TERM
    ${c05}▉▉  | ${f1}term font ${f0}.... $f2$termfn
    ${c13}  ▉▉| ${f1}system font ${f0}.. $f2$systfn
    ${c06}▉▉  |
    ${c14}  ▉▉| ${f1}gtk theme ${f0}.... $f2$gtktheme
    ${c07}▉▉  | ${f1}icon theme ${f0}... $f2$icons
    ${c15}  ▉▉|

EOF

PS1="\[\e[0;34m\]┌─[\[\e[1;36m\u\e[0;34m\]]──[\[\e[1;32m\]${HOSTNAME%%.*}\[\e[0;34m\]]\[\e[1;37m\]: \w $\[\e[0;34m\]\n\[\e[0;34m\]└────■ \[\e[1;36m\]▶▶  \[\e[00;00m\]"

function cdls { cd "$1"; ls --color;}
alias cd='cdls'

export LS_OPTIONS='--color=auto'

eval "`dircolors`"
alias ls='ls $LS_OPTIONS'


#Colors:
#..BLACK='\e[0;30m'
#  BLUE='\e0;34m'
#  BROWN='\e[0;33m'
#  CYAN='\e[0;36m'
#  DARKGRAY='\e[1;30m'
#  GRAY='\e[0;37m'
#  GREEN='\e[32m'
#  LIGHTBLUE='\e[1;34m'
#  LIGHTCYAN='\e[1;36m'
#  LIGHTGRAY='\e[0;37m'
#  LIGHTGREEN='\e[1;32m'
#  LIGHTPURPLE='\e[1;35m'
#  LIGHTRED='\e[1;31m'
#  PURPLE='\e[0;35m'
#  RED='\e[0;31m'
#  YELLOW='\e[1;33m'fortune
