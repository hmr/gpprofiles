#!/bin/sh
# vim: set ft=sh syn=bash fenc=utf-8 ff=unix fixeol et sw=2 ts=2 sts=2: #GPP default modeline for shell scripts

echo "$(curl -s -4 --insecure "https://domains.google.com/checkip")"

