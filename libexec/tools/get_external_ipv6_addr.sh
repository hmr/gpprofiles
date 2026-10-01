#!/bin/sh
# vim: set ft=sh syn=bash fenc=utf-8 ff=unix fixeol et sw=2 ts=2 sts=2: #GPP default modeline for shell scripts

echo "$(curl -s -6 -H "Host:domains.google.com" --insecure "https://[2404:6800:4004:824::200e]/checkip")"


