#!/usr/bin/env bash
# Crude functionless script to check for TERM values that are safe to
# auto-launch tmux on login with
[[ "$TERM" = "xterm" ]] && echo 1 && exit
[[ "$TERM" = "xterm-256color" ]] && echo 1 && exit
[[ "$TERM" = "rxvt" ]] && echo 1 && exit
[[ "$TERM" = "urxvt" ]] && echo 1 && exit
echo 0
