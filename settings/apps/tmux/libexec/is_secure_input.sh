#!/bin/dash

ioreg -l -d 1 -w 0 | grep -q "SecureInput" \
  && echo -n " SI " # || echo -n "#[bg=green,fg=colour0] secure input not enabled "

# vim: set ft=sh syn=sh ff=unix fenc=utf-8 ts=2 sw=2 sts=2 et:
