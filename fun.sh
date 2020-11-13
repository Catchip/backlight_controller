#!/bin/zsh

# get the filepath to backlight_brightness 
backlight_path="/sys/class/backlight/"$(ls /sys/class/backlight/)"/brightness"

maxbright_path="/sys/class/backlight/"$(ls /sys/class/backlight/)"/max_brightness"

max_brightness=$(cat $maxbright_path)
actul_brightness=$(cat $backlight_path)

echo $max_brightness
echo $actul_brightness


function fun(){
    delta=$((max_brightness / 20))
    set_brightness=$(($delta * $1))
    echo $set_brightness > $backlight_path
}

function display(){
    clear
    char="  "
    str=[
    for ((i=0 ; i<20 ; i++)){
        ((i<$1)) && char="# "
        str+=$char
        char="  "
    }
    str+=]
    echo $str
}

zmodload zsh/net/socket
zsocket test.socket
fd=$REPLY


level=$((($actul_brightness * 20 ) / $max_brightness))
percent=$(($level * 5))
echo $percent | dialog --title "BackLight Controller" --gauge "----------------------Level:$level--------------------------" 8 60 
#dialog --title "installation" "installation" 10 30 $percent

op=0
while [[ $op != 'q' ]]; do
    read -k 1 op
    if [[ $op == 'h' ]]; then
        [[ $level != '1' ]] && level=$(($level-1))
        fun $level
    fi

    if [[ $op == 'l' ]]; then
        [[ $level != "20" ]] && level=$(($level+1))
        fun $level
    fi

    percent=$(($level * 5))
    echo $percent | dialog --title "BackLight Controller" --gauge "----------------------Level:$level--------------------------" 8 60 
    #dialog --title "installation pro" "installation" 10 30 $percent --keep-window
done


