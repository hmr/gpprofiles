#!/bin/dash

PID="$(ioreg -l -d 1 -w 0 | grep -Po '"[a-zA-Z]+SecureInputPID"=[0-9]+' | uniq | cut -d= -f2)"
ps -p "$PID" > /dev/null 2>&1 /dev/null && echo -n " SI "

# vim: set ft=sh syn=sh ff=unix fenc=utf-8 ts=2 sw=2 sts=2 et:
