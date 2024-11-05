#!/usr/bin/env sh

org_bar=$(pgrep -a polybar | grep menu | cut -d" " -f1)
if [ $org_bar ]; then
    kill -9 $org_bar
else
    polybar menu &
fi
