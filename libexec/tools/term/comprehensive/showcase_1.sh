#!/usr/bin/env bash
# =============================================================================
# Terminal Text Decoration (SGR) Comprehensive Test
# Tests all known Select Graphic Rendition escape sequences
# =============================================================================

ESC="\033["
RESET="${ESC}0m"

# Print a section header
section() {
    echo ""
    echo -e "${ESC}1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${ESC}1;36m  $1${RESET}"
    echo -e "${ESC}1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

# Print a test line: SGR code, description, sample text
# Usage: test_sgr <code> <description>
test_sgr() {
    local code="$1"
    local desc="$2"
    printf "  SGR %4s : %-30s : \033[%smThe quick brown fox jumps over the lazy dog\033[0m\n" \
        "$code" "$desc" "$code"
}

# Print a reset verification line: decorated → reset → normal text
# Usage: test_sgr_reset <set_code> <reset_code> <description>
test_sgr_reset() {
    local set_code="$1"
    local reset_code="$2"
    local desc="$3"
    printf "  SGR %4s → %s : %-20s : " "$set_code" "$reset_code" "$desc"
    printf "\033[%smDecorated\033[%sm Then Normal" "$set_code" "$reset_code"
    printf " ← should look the same as: "
    printf "Normal\033[0m\n"
}

echo -e "${ESC}1;33m"
echo "╔══════════════════════════════════════════════════════════╗"
echo "║ Terminal Text Decoration (SGR) Comprehensive Test        ║"
echo "║ Testing ECMA-48 / ISO 6429 SGR Parameters                ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo -e "${RESET}"
echo "  Terminal: ${TERM:-unknown}"
echo "  TERM_PROGRAM: ${TERM_PROGRAM:-unknown}"
echo "  COLORTERM: ${COLORTERM:-unknown}"

# =========================================================================
section "1. Basic Text Attributes (SGR 0-9)"
# =========================================================================
test_sgr "0"  "Reset / Normal"
test_sgr "1"  "Bold / Increased intensity"
test_sgr "2"  "Dim / Faint / Decreased intensity"
test_sgr "3"  "Italic"
test_sgr "4"  "Underline"
test_sgr "5"  "Slow Blink (<150 per min)"
test_sgr "6"  "Rapid Blink (>=150 per min)"
test_sgr "7"  "Reverse Video / Inverse"
test_sgr "8"  "Concealed / Hidden"
test_sgr "9"  "Crossed-out / Strikethrough"

# =========================================================================
section "2. Font Selection (SGR 10-20)"
# =========================================================================
test_sgr "10" "Primary (default) font"
test_sgr "11" "Alternative font 1"
test_sgr "12" "Alternative font 2"
test_sgr "13" "Alternative font 3"
test_sgr "14" "Alternative font 4"
test_sgr "15" "Alternative font 5"
test_sgr "16" "Alternative font 6"
test_sgr "17" "Alternative font 7"
test_sgr "18" "Alternative font 8"
test_sgr "19" "Alternative font 9"
test_sgr "20" "Fraktur (Gothic)"

# =========================================================================
section "3. Extended Underline & Intensity (SGR 21-29)"
# =========================================================================
test_sgr "21" "Double underline (or Bold off)"
test_sgr "22" "Normal intensity (not bold/dim)"
test_sgr "23" "Not italic, not Fraktur"
test_sgr "24" "Not underlined"
test_sgr "25" "Not blinking"
test_sgr "26" "Proportional spacing"
test_sgr "27" "Not reversed"
test_sgr "28" "Reveal (not concealed)"
test_sgr "29" "Not crossed out"

# =========================================================================
section "4. Standard Foreground Colors (SGR 30-37, 39)"
# =========================================================================
test_sgr "30" "FG: Black"
test_sgr "31" "FG: Red"
test_sgr "32" "FG: Green"
test_sgr "33" "FG: Yellow"
test_sgr "34" "FG: Blue"
test_sgr "35" "FG: Magenta"
test_sgr "36" "FG: Cyan"
test_sgr "37" "FG: White"
test_sgr "39" "FG: Default"

# =========================================================================
section "5. Standard Background Colors (SGR 40-47, 49)"
# =========================================================================
test_sgr "40" "BG: Black"
test_sgr "41" "BG: Red"
test_sgr "42" "BG: Green"
test_sgr "43" "BG: Yellow"
test_sgr "44" "BG: Blue"
test_sgr "45" "BG: Magenta"
test_sgr "46" "BG: Cyan"
test_sgr "47" "BG: White"
test_sgr "49" "BG: Default"

# =========================================================================
section "6. Extended Color Attributes (SGR 50-65)"
# =========================================================================
test_sgr "50" "Disable proportional spacing"
test_sgr "51" "Framed"
test_sgr "52" "Encircled"
test_sgr "53" "Overlined"
test_sgr "54" "Not framed, not encircled"
test_sgr "55" "Not overlined"
# SGR 56-57 are unassigned
test_sgr "58;5;196" "Underline color (256: red)"
test_sgr "58;2;0;128;255" "Underline color (RGB: #0080FF)"
test_sgr "59" "Default underline color"
test_sgr "60" "Ideogram underline / right side line"
test_sgr "61" "Ideogram double underline / double right"
test_sgr "62" "Ideogram overline / left side line"
test_sgr "63" "Ideogram double overline / double left"
test_sgr "64" "Ideogram stress marking"
test_sgr "65" "No ideogram attributes"

# =========================================================================
section "7. Bright/High-Intensity Foreground (SGR 90-97)"
# =========================================================================
test_sgr "90" "FG: Bright Black (Gray)"
test_sgr "91" "FG: Bright Red"
test_sgr "92" "FG: Bright Green"
test_sgr "93" "FG: Bright Yellow"
test_sgr "94" "FG: Bright Blue"
test_sgr "95" "FG: Bright Magenta"
test_sgr "96" "FG: Bright Cyan"
test_sgr "97" "FG: Bright White"

# =========================================================================
section "8. Bright/High-Intensity Background (SGR 100-107)"
# =========================================================================
test_sgr "100" "BG: Bright Black (Gray)"
test_sgr "101" "BG: Bright Red"
test_sgr "102" "BG: Bright Green"
test_sgr "103" "BG: Bright Yellow"
test_sgr "104" "BG: Bright Blue"
test_sgr "105" "BG: Bright Magenta"
test_sgr "106" "BG: Bright Cyan"
test_sgr "107" "BG: Bright White"

# =========================================================================
section "9. 256-Color Mode (SGR 38;5;n / 48;5;n)"
# =========================================================================
echo "  --- Foreground 256 colors (SGR 38;5;0..255) ---"
for i in $(seq 0 15); do
    printf "\033[38;5;%sm%4d " "$i" "$i"
done
echo -e "${RESET}"
for row in $(seq 0 5); do
    for col in $(seq 0 35); do
        local_idx=$((16 + row * 36 + col))
        if [ "$local_idx" -le 255 ]; then
            printf "\033[38;5;%sm%4d " "$local_idx" "$local_idx"
        fi
    done
    echo -e "${RESET}"
done
echo ""
echo "  --- Grayscale ramp (232-255) ---"
for i in $(seq 232 255); do
    printf "\033[38;5;%sm%4d " "$i" "$i"
done
echo -e "${RESET}"

echo ""
echo "  --- Background 256 colors (first 16 + grayscale) ---"
for i in $(seq 0 15); do
    printf "\033[48;5;%sm%4d " "$i" "$i"
done
echo -e "${RESET}"
for i in $(seq 232 255); do
    printf "\033[48;5;%sm%4d " "$i" "$i"
done
echo -e "${RESET}"

# =========================================================================
section "10. 24-bit True Color (SGR 38;2;r;g;b / 48;2;r;g;b)"
# =========================================================================
echo "  --- Foreground RGB gradient ---"
printf "  "
for i in $(seq 0 2 255); do
    printf "\033[38;2;%d;0;0m█" "$i"
done
echo -e "${RESET}"
printf "  "
for i in $(seq 0 2 255); do
    printf "\033[38;2;0;%d;0m█" "$i"
done
echo -e "${RESET}"
printf "  "
for i in $(seq 0 2 255); do
    printf "\033[38;2;0;0;%dm█" "$i"
done
echo -e "${RESET}"
printf "  "
for i in $(seq 0 2 255); do
    printf "\033[38;2;%d;%d;%dm█" "$i" "$((255 - i))" "$((i / 2))"
done
echo -e "${RESET}"

echo ""
echo "  --- Background RGB gradient ---"
printf "  "
for i in $(seq 0 2 255); do
    printf "\033[48;2;%d;%d;%dm " "$i" "$((255 - i))" "$((128 + i / 2))"
done
echo -e "${RESET}"

# =========================================================================
section "11. Underline Styles (Kitty / VTE / iTerm2 extensions)"
# =========================================================================
echo "  These use SGR 4:x syntax (colon-separated sub-parameters):"
echo ""
printf "  SGR 4:0 : %-30s : \033[4:0mNo underline (reset)\033[0m\n" "No underline"
printf "  SGR 4:1 : %-30s : \033[4:1mSingle underline (straight)\033[0m\n" "Straight underline"
printf "  SGR 4:2 : %-30s : \033[4:2mDouble underline\033[0m\n" "Double underline"
printf "  SGR 4:3 : %-30s : \033[4:3mCurly/wavy underline\033[0m\n" "Curly underline"
printf "  SGR 4:4 : %-30s : \033[4:4mDotted underline\033[0m\n" "Dotted underline"
printf "  SGR 4:5 : %-30s : \033[4:5mDashed underline\033[0m\n" "Dashed underline"
echo ""
echo "  Underline styles with color (SGR 4:x combined with SGR 58;2;r;g;b):"
printf "  Curly + Red    : \033[4:3m\033[58;2;255;0;0mWavy red underline\033[0m\n"
printf "  Dotted + Green : \033[4:4m\033[58;2;0;255;0mDotted green underline\033[0m\n"
printf "  Dashed + Blue  : \033[4:5m\033[58;2;0;128;255mDashed blue underline\033[0m\n"
printf "  Double + Gold  : \033[4:2m\033[58;2;255;200;0mDouble gold underline\033[0m\n"

# =========================================================================
section "12. Combined Attributes"
# =========================================================================
test_sgr "1;3"       "Bold + Italic"
test_sgr "1;4"       "Bold + Underline"
test_sgr "1;3;4"     "Bold + Italic + Underline"
test_sgr "1;9"       "Bold + Strikethrough"
test_sgr "3;9"       "Italic + Strikethrough"
test_sgr "1;3;9"     "Bold + Italic + Strikethrough"
test_sgr "2;3"       "Dim + Italic"
test_sgr "1;4;53"    "Bold + Underline + Overline"
test_sgr "4;53"      "Underline + Overline"
test_sgr "7;1"       "Reverse + Bold"
test_sgr "3;4;7"     "Italic + Underline + Reverse"
test_sgr "1;3;4;7;9" "Bold+Italic+Underline+Reverse+Strike"
test_sgr "1;31"      "Bold + Red FG"
test_sgr "1;3;33;44" "Bold + Italic + Yellow on Blue"
test_sgr "2;37;41"   "Dim + White on Red"
test_sgr "1;5;31"    "Bold + Blink + Red"
test_sgr "7;91;43"   "Reverse + BrightRed + YellowBG"

# =========================================================================
section "13. Combined Underline Styles + Attributes"
# =========================================================================
printf "  SGR 1+4           Bold + Curly underline           : \033[1m\033[4:3mBold Curly\033[0m\n"
printf "  SGR 3+4           Italic + Dashed underline        : \033[3m\033[4:5mItalic Dashed\033[0m\n"
printf "  SGR 1+3+4+58      Bold+Italic + Dotted + Red UL    : \033[1;3m\033[4:4m\033[58;2;255;0;0mBold Italic Dotted Red\033[0m\n"
printf "  SGR 9+4+58        Strikethrough + Wavy + Blue UL   : \033[9m\033[4:3m\033[58;2;0;100;255mStrike Wavy Blue\033[0m\n"
printf "  SGR 2+4+53        Dim + Double UL + Overline       : \033[2m\033[4:2m\033[53mDim Double Overline\033[0m\n"
printf "  SGR 1+3+9+53+4+58 All: Bold+Ital+Strike+Curly+OL   : \033[1;3;9;53m\033[4:3m\033[58;2;255;128;0mEverything\033[0m\n"

# =========================================================================
section "14. Hyperlinks (OSC 8)"
# =========================================================================
echo "  OSC 8 Hyperlink support test:"
printf "  Click here: \033]8;;https://example.com\033\\Example Link\033]8;;\033\\ (should be clickable)\n"
printf "  With id:    \033]8;id=test1;https://github.com\033\\GitHub Link\033]8;;\033\\ (hover to see URL)\n"

# =========================================================================
section "15. Superscript / Subscript (SGR 73-75)"
# =========================================================================
echo "  (Mintty and a few other terminals support these)"
test_sgr "73" "Superscript"
test_sgr "74" "Subscript"
test_sgr "75" "Neither superscript nor subscript"
printf "  Combined: H\033[74m2\033[75mO = water, E=mc\033[73m2\033[75m\n"

# =========================================================================
section "16. Miscellaneous / Rare SGR Codes"
# =========================================================================
test_sgr "66" "UNASSIGNED (66)"
test_sgr "67" "UNASSIGNED (67)"
test_sgr "68" "UNASSIGNED (68)"
test_sgr "69" "UNASSIGNED (69)"
echo ""
echo "  Note: SGR 38/48 (extended color) are covered in sections 9 & 10."
echo "  Note: SGR 56-57 are reserved/unassigned in ECMA-48."

# =========================================================================
section "17. Reset Codes Verification"
# =========================================================================
echo "  Verifying that individual reset codes properly restore normal rendering."
echo "  'Then Normal' text after the reset code should look identical to 'Normal' at the end."
echo ""
test_sgr_reset "1"  "22" "Bold → Normal"
test_sgr_reset "2"  "22" "Dim → Normal"
test_sgr_reset "3"  "23" "Italic → Normal"
test_sgr_reset "4"  "24" "Underline → Normal"
test_sgr_reset "5"  "25" "Blink → Normal"
test_sgr_reset "7"  "27" "Reverse → Normal"
test_sgr_reset "8"  "28" "Hidden → Normal"
test_sgr_reset "9"  "29" "Strike → Normal"
test_sgr_reset "53" "55" "Overline → Normal"
test_sgr_reset "51" "54" "Framed → Normal"
test_sgr_reset "52" "54" "Encircled → Normal"
echo ""
echo "  Underline style resets (4:x → 4:0):"
printf "  SGR 4:3 → 4:0 : Curly → Normal     : "
printf "\033[4:3mDecorated\033[4:0m Then Normal ← should look the same as: Normal\033[0m\n"
printf "  SGR 4:4 → 4:0 : Dotted → Normal    : "
printf "\033[4:4mDecorated\033[4:0m Then Normal ← should look the same as: Normal\033[0m\n"
printf "  SGR 4:5 → 4:0 : Dashed → Normal    : "
printf "\033[4:5mDecorated\033[4:0m Then Normal ← should look the same as: Normal\033[0m\n"

# =========================================================================
section "18. SGR with Colon-Separated Sub-Parameters"
# =========================================================================
echo "  Modern terminals support colon-separated parameters (ISO 8613-6):"
echo ""
printf "  SGR 38:2::255:0:0   FG RGB (colon) : \033[38:2::255:0:0mRed text via colon syntax\033[0m\n"
printf "  SGR 48:2::0:128:0   BG RGB (colon) : \033[48:2::0:128:0mGreen BG via colon syntax\033[0m\n"
printf "  SGR 38:5:208        FG 256 (colon) : \033[38:5:208mOrange via colon syntax\033[0m\n"
printf "  SGR 48:5:33         BG 256 (colon) : \033[48:5:33mBlue BG via colon syntax\033[0m\n"
printf "  SGR 58:2::255:0:128 UL color(colon): \033[4:3m\033[58:2::255:0:128mPink curly underline\033[0m\n"

# =========================================================================
section "19. Stress Test: All Attributes Simultaneously"
# =========================================================================
printf "  SGR 1+2+3+4+5+7+8+9_53   \033[1;2;3;4;5;7;8;9;53mAll SGR 1-9 + 53 (may look chaotic!)\033[0m\n\n"
printf "  SGR 1+3+4+9+53+91+48+58  \033[1;3;4:3;9;53;91;48;2;32;32;32m\033[58;2;255;255;0mMaximum decoration\033[0m\n"
echo ""
echo "  (If your terminal survived that, it's pretty robust! 💪)"

# =========================================================================
section "Summary"
# =========================================================================
echo "  Tested SGR parameters:"
echo "    0-9    : Basic attributes (bold, dim, italic, underline, blink, etc.)"
echo "    10-20  : Font selection + Fraktur"
echo "    21-29  : Double underline + reset codes"
echo "    30-37  : Standard foreground colors"
echo "    39     : Default foreground"
echo "    40-47  : Standard background colors"
echo "    49     : Default background"
echo "    50-65  : Frame, encircle, overline, underline color, ideograms"
echo "    73-75  : Superscript / subscript"
echo "    90-97  : Bright foreground colors"
echo "    100-107: Bright background colors"
echo "    38;5;n : 256-color foreground"
echo "    48;5;n : 256-color background"
echo "    38;2;* : 24-bit RGB foreground"
echo "    48;2;* : 24-bit RGB background"
echo "    58;2;* : Underline color (RGB)"
echo "    58;5;n : Underline color (256)"
echo "    4:0-5  : Underline styles (none/straight/double/curly/dotted/dashed)"
echo "    OSC 8  : Hyperlinks"
echo ""
echo "  Total: ~150+ distinct SGR parameter combinations tested."
echo ""
