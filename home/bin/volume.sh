#!/bin/sh
amixer_output=`amixer get Master`
onToken=`egrep -o "\[(on|off)\]" <<< $amixer_output`

amplitudeToken=`egrep -o "\[[0-9]+%\]" <<< $amixer_output | egrep -o "[0-9]+"`

if [ "$onToken" == "[on]" ]; then
    echo "${amplitudeToken}+"
else
    echo "${amplitudeToken}-"
fi
