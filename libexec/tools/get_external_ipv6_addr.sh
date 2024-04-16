#!/bin/sh

echo "$(curl -s -6 -H "Host:domains.google.com" --insecure "https://[2404:6800:4004:824::200e]/checkip")"


