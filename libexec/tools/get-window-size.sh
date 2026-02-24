#!/usr/bin/env bash
set -euo pipefail

wait_sec=5
quiet=0

usage() {
cat <<EOF
Usage:
  frontwin [SECONDS]
  frontwin [-q|--quiet] [SECONDS]

Options:
  -q, --quiet   suppress messages and countdown

Examples:
  frontwin
  frontwin 3
  frontwin -q
  frontwin -q 2.5
EOF
}

# ---- parse args ----
while [[ $# -gt 0 ]]; do
  case "$1" in
    -q|--quiet)
      quiet=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      wait_sec="$1"
      shift
      ;;
  esac
done

# validate number
if ! [[ "$wait_sec" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo "Error: SECONDS must be numeric" >&2
  exit 2
fi

# ---- user message ----
if [[ "$quiet" -eq 0 ]]; then
  echo "Switch to the target window to measure its size..."
fi

# ---- countdown ----
if [[ "$quiet" -eq 0 ]]; then
  whole=${wait_sec%.*}
  if [[ "$whole" =~ ^[0-9]+$ ]] && (( whole >= 1 )); then
    for ((i=whole; i>=1; i--)); do
      printf '\rWaiting... %ds ' "$i"
      sleep 1
    done
    printf '\rWaiting... now!   \n'
  fi

  # fractional remainder
  python3 - <<PY
import time
time.sleep(float("$wait_sec") - int(float("$wait_sec")))
PY
else
  sleep "$wait_sec"
fi

# ---- AppleScript: measure front window ----
osascript <<'END_OF_APPLESCRIPT'
tell application "System Events"
	tell (first process whose frontmost is true)
		if (count of windows) is 0 then return "no window"
		
		set appName to name
		tell front window
			set {x, y} to position
			set {w, h} to size
		end tell
	end tell
end tell

return appName & " " & x & "," & y & " " & w & "x" & h
END_OF_APPLESCRIPT
