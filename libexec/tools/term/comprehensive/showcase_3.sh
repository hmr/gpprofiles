#!env bash

echo "# 24-bit (true-color)"
# based on: https://gist.github.com/XVilka/8346728
term_cols=132
cols=$(echo "${term_cols} / 2" | bc 2> /dev/null)
rows=$(( cols / 2 ))
awk -v cols="$cols" -v rows="$rows" 'BEGIN{
    s="  ";
    m=cols+rows;
    for (row = 0; row<rows; row++) {
      for (col = 0; col<cols; col++) {
          i = row+col;
          r = 255-(i*255/m);
          g = (i*510/m);
          b = (i*255/m);
          if (g>255) g = 510-g;
          printf "\033[48;2;%d;%d;%dm", r,g,b;
          printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
          printf "%s\033[0m", substr(s,(col+row)%2+1,1);
      }
      printf "\n";
    }
    printf "\n\n";
}'

echo "# text decorations"
printf '\e[1mBold or increased intensity\e[22m (SGR1)\n'
printf '\e[2mFaint, decreased intensity, or dim\e[22m (SGR2)\n'
printf '\e[3mitalic\e[23m (SGR3)\n'
printf '\e[4munderline\e[24m (SGR4)\n'
printf '\e[4:1mthis is also underline\e[24m (SGR4:1)\n'
printf '\e[21mdouble underline\e[24m (SGR21)\n'
printf '\e[4:2mdouble underline\e[24m (SGR4:2)\n'
printf '\e[4:3mcurly underline\e[24m (SGR4:3)\n'
printf '\e[4:4mdotted underline\e[24m (SGR4:4)\n'
printf '\e[4:5mdashed underline\e[24m (SGR4:5)\n'
printf '\e[58;5;10;4mcolored underline\e[59;24m (SGR58;5;10;4)\n'
printf '\e[5mblink\e[25m (SGR5)\n'
printf '\e[6mrapid blink\e[25m (SGR6)\n'
printf '\e[7mreverse\e[27m (SGR7)\n'
printf '\e[8minvisible\e[28m <- invisible (but copy-pasteable)(SGR8)\n'
printf '\e[9mstrikethrough\e[29m (SGR9)\n'
printf '\e[53moverline\e[55m (SGR53)\n'
printf '\e[73mSuperscript\e[75m (SGR73)\n'
printf '\e[74mSubscript\e[75m (SGR74)\n'
echo

echo "# Japanese character"
echo "0        1         2         3         4         5         6         7         8"
echo "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
echo "私の名前はnakanoです。"
echo "本日はｾｲﾃﾝなり。"
echo

echo "# magic string (see https://en.wikipedia.org/wiki/Unicode#Web)"
echo "é Δ Й ק م ๗ あ 叶 葉 말"
echo

echo "# emojis"
echo "😃😱😵"
echo

echo "# East Asia Ambiguous characters"
echo -e "1234567890\n◎a★b"
echo "☆a★B"
printf "\xe3\x81\x82\xe3\x81\x84\xe3\x81\x86\xe3\x81\x88\xe3\x81\x8a\n"
printf "\xe2\x98\x86\xe2\x98\x86\xe2\x98\x86\xe2\x98\x86\xe2\x98\x86\n"
echo

echo "# right-to-left ('w' symbol should be at right side)"
echo "שרה"
echo

echo "# sixel graphics"
printf '\eP0;0;0q"1;1;64;64#0;2;0;0;0#1;2;100;100;100#1~{wo_!11?@FN^!34~^NB
@?_ow{~$#0?BFN^!11~}wo_!34?_o{}~^NFB-#1!5~}{o_!12?BF^!25~^NB@??ow{!6~$#0!5?
@BN^!12~{w_!25?_o{}~~NFB-#1!10~}w_!12?@BN^!15~^NFB@?_w{}!10~$#0!10?@F^!12~}
{o_!15?_ow{}~^FB@-#1!14~}{o_!11?@BF^!7~^FB??_ow}!15~$#0!14?@BN^!11~}{w_!7?_
w{~~^NF@-#1!18~}{wo!11?_r^FB@??ow}!20~$#0!18?@BFN!11~^K_w{}~~NF@-#1!23~M!4?
_oWMF@!6?BN^!21~$#0!23?p!4~^Nfpw}!6~{o_-#1!18~^NB@?_ow{}~wo!12?@BFN!17~$#0!
18?_o{}~^NFB@?FN!12~}{wo-#1!13~^NB@??_w{}!9~}{w_!12?BFN^!12~$#0!13?_o{}~~^F
B@!9?@BF^!12~{wo_-#1!8~^NFB@?_w{}!19~{wo_!11?@BN^!8~$#0!8?_ow{}~^FB@!19?BFN
^!11~}{o_-#1!4~^NB@?_ow{!28~}{o_!12?BF^!4~$#0!4?_o{}~^NFB!28?@BN^!12~{w_-#1
NB@???GM!38NMG!13?@BN$#0?KMNNNF@!38?@F!13NMK-\e\'

