#!/bin/bash
history_file=$HOME/.uzbl/history
 
COLORS=" -nb #303030 -nf khaki -sb #CCFFAA -sf #303030"
OPTIONS=" -i -l 10"
 
goto=`cut -d " " -f 3 $history_file | uniquer | dmenu $OPTIONS $COLORS`
 
#[ -n "$goto" ] && uzblctrl -s $5 -c "uri $goto"
[ -n "$goto" ] && echo "act uri $goto" > $4
