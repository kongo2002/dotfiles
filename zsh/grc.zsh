GRC=`which grc`

if [ "$TERM" != dumb ] && [ -e $GRC ]; then
    alias colorize="$GRC -es --colour=auto"

    alias as='colorize as'
    alias configure='colorize ./configure'
    alias diff='colorize diff'
    alias g++='colorize g++'
    alias gas='colorize gas'
    alias gcc='colorize gcc'
    alias ifconfig='colorize ifconfig'
    alias ld='colorize ld'
    alias make='colorize make'
    alias mount='colorize mount'
    alias netstat='colorize netstat'
    alias ping='colorize ping -c 5'
    alias ps='colorize ps'
    alias traceroute='colorize traceroute'
    alias xbuild='colorize xbuild'
fi
