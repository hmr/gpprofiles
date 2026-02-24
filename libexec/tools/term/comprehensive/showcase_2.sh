#!/usr/bin/env bash
set -euo pipefail

# Print ESC literally via printf, not echo -e
ESC=$'\033'
CSI="${ESC}["
RST="${CSI}0m"

term_w=${COLUMNS:-0}

hr() {
  local ch="${1:--}"
  if [[ "$term_w" -gt 0 ]]; then
    printf '%*s\n' "$term_w" '' | tr ' ' "$ch"
  else
    printf '%s\n' "----------------------------------------------------------------"
  fi
}

# usage: show "<label>" "<sgr;...>" "<sample text>"
show() {
  local label="$1" sgr="$2" text="$3"
  # Keep label aligned-ish
  printf "%-28s : %b%s%b\n" "$label" "${CSI}${sgr}m" "$text" "$RST"
}

# usage: show_raw "<label>" "<escape-seq>" "<sample>"
show_raw() {
  local label="$1" seq="$2" text="$3"
  printf "%-28s : %b%s%b\n" "$label" "$seq" "$text" "$RST"
}

banner() {
  hr "="
  printf "SGR / text-decoration capability probe\n"
  printf "Terminal: %s | TERM=%s\n" "${TERM_PROGRAM:-unknown}" "${TERM:-unknown}"
  printf "Tip: compare in different emulators (iTerm2, Terminal.app, kitty, WezTerm, Alacritty, GNOME Terminal...)\n"
  hr "="
}

# Some terminals support querying; keep it light (no promises).
soft_note() {
  printf "%s\n" "Note: Unsupported attributes may be ignored or mapped differently."
  printf "%s\n" "      Italic often depends on font face availability."
}

# 24-bit (truecolor) gradient bar
truecolor_bar() {
  hr "-"
  printf "TrueColor gradient bar (24-bit) — should be smooth, not banded.\n"
  local i r g b
  for i in $(seq 0 79); do
    r=$(( (i*255)/79 ))
    g=$(( 255 - (i*255)/79 ))
    b=$(( ( (i*255)/79 ) / 2 ))
    printf "%b \b" "${CSI}48;2;${r};${g};${b}m"
  done
  printf "%b\n" "$RST"
}

# 256-color ramp
color256_ramp() {
  hr "-"
  printf "256-color ramp (0-255):\n"
  local i
  for i in $(seq 0 255); do
    # background color blocks + index
    printf "%b%3d%b " "${CSI}48;5;${i}m" "$i" "$RST"
    if (( (i + 1) % 16 == 0 )); then
      printf "\n"
    fi
  done
}

basic_colors() {
  hr "-"
  printf "Basic 8/16 colors (foreground / background):\n"
  show "FG 30-37" "30" "black"
  show "" "31" "red"
  show "" "32" "green"
  show "" "33" "yellow"
  show "" "34" "blue"
  show "" "35" "magenta"
  show "" "36" "cyan"
  show "" "37" "white"
  show "FG bright 90-97" "90" "bright black"
  show "" "91" "bright red"
  show "" "92" "bright green"
  show "" "93" "bright yellow"
  show "" "94" "bright blue"
  show "" "95" "bright magenta"
  show "" "96" "bright cyan"
  show "" "97" "bright white"

  hr "."
  show "BG 40-47" "40" "black bg"
  show "" "41" "red bg"
  show "" "42" "green bg"
  show "" "43" "yellow bg"
  show "" "44" "blue bg"
  show "" "45" "magenta bg"
  show "" "46" "cyan bg"
  show "" "47" "white bg"
  show "BG bright 100-107" "100" "bright black bg"
  show "" "101" "bright red bg"
  show "" "102" "bright green bg"
  show "" "103" "bright yellow bg"
  show "" "104" "bright blue bg"
  show "" "105" "bright magenta bg"
  show "" "106" "bright cyan bg"
  show "" "107" "bright white bg"

  hr "."
  show "Default FG/BG" "39;49" "reset to default colors"
}

text_attributes() {
  hr "-"
  printf "Text attributes (SGR):\n"

  show "0 reset" "0" "reset"
  show "1 bold" "1" "bold"
  show "2 faint" "2" "faint / dim"
  show "3 italic" "3" "italic (font-dependent)"
  show "4 underline" "4" "underline"
  show "5 blink slow" "5" "blink slow (often disabled)"
  show "6 blink rapid" "6" "blink rapid (rare)"
  show "7 inverse" "7" "inverse / reverse video"
  show "8 conceal" "8" "conceal (hidden text?)"
  show "9 strikethrough" "9" "strikethrough"

  hr "."
  show "21 double underline*" "21" "double underline (or bold off in some)"
  show "22 normal intensity" "22" "bold/faint off"
  show "23 italic off" "23" "italic off"
  show "24 underline off" "24" "underline off"
  show "25 blink off" "25" "blink off"
  show "27 inverse off" "27" "inverse off"
  show "28 reveal" "28" "conceal off"
  show "29 strike off" "29" "strikethrough off"

  hr "."
  show "53 overline" "53" "overline"
  show "55 overline off" "55" "overline off"

  hr "."
  show "51 framed" "51" "framed"
  show "52 encircled" "52" "encircled"
  show "54 frame/encircle off" "54" "frame/encircle off"

  hr "."
  show "10 primary font" "10" "primary font"
  show "11 alt font 1" "11" "alternate font 1 (rare)"
  show "12 alt font 2" "12" "alternate font 2 (rare)"
  show "20 fraktur" "20" "fraktur (rare)"

  hr "."
  show "73 superscript" "73" "superscript"
  show "74 subscript" "74" "subscript"
  show "75 script off" "75" "super/sub off"

  hr "."
  show "26 proportional" "26" "proportional spacing (rare)"
  show "50 proportional off" "50" "proportional off"
}

underline_variants() {
  hr "-"
  printf "Underline variants (SGR 4:... — supported in some terminals):\n"
  show "4:0 underline off" "4:0" "underline off (variant form)"
  show "4:1 single underline" "4:1" "single underline"
  show "4:2 double underline" "4:2" "double underline"
  show "4:3 curly underline" "4:3" "curly underline (wavy-ish)"
  show "4:4 dotted underline" "4:4" "dotted underline"
  show "4:5 dashed underline" "4:5" "dashed underline"

  hr "."
  printf "Underline color (SGR 58/59 — supported in some terminals):\n"
  # Set underline + underline color red, green, truecolor, then reset underline color
  show "underline + ucolor red" "4;58;5;1" "underline color index=1 (red)"
  show "underline + ucolor green" "4;58;5;2" "underline color index=2 (green)"
  show "underline + ucolor truecolor" "4;58;2;255;128;0" "underline truecolor orange"
  show "59 ucolor default" "59;4" "underline color back to default"
  show "24 underline off" "24" "underline off"
}

color_combos() {
  hr "-"
  printf "Combos: attributes + colors (to see precedence/stacking):\n"
  show "bold + fg bright" "1;96" "bold + bright cyan"
  show "italic + fg" "3;35" "italic + magenta"
  show "underline + fg + bg" "4;30;103" "underline + black on bright yellow"
  show "inverse + fg/bg" "7;32;44" "inverse + (green / blue bg)??"
  show "strike + overline" "9;53" "strikethrough + overline"
  show "faint + underline" "2;4" "faint + underline"
}

reset_torture() {
  hr "-"
  printf "Reset edge cases (do attributes leak?):\n"
  # Intentionally omit reset mid-way, then reset later
  printf "  Leaky test: "
  printf "%b" "${CSI}1;4;31m"
  printf "BOLD+UNDERLINE+RED "
  printf "%b" "${CSI}22m"
  printf "bold off? "
  printf "%b" "${CSI}24m"
  printf "underline off? "
  printf "%b" "${CSI}39m"
  printf "fg default? "
  printf "%b" "$RST"
  printf "reset\n"
}

main() {
  banner
  soft_note

  text_attributes
  underline_variants
  basic_colors
  color256_ramp
  truecolor_bar
  color_combos
  reset_torture

  hr "="
  printf "Done. If something looks identical across many lines, that feature may be unsupported.\n"
  hr "="
}

main "$@"
