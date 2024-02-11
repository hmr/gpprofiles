" Part of GPP(General Puropose Profiles)
" vim: ft=vim ts=2 sts=2 sw=2 expandtab fenc=utf-8 ff=unix
" Vim key mapping
" ORIGIN: 2021-03-01 by hmr

scriptencoding utf-8

map     [1;5A     <C-Up>
map!    [1;5A     <C-Up>
" map     [1;5A     <C-Tab>
" map!    [1;5A     <C-Tab>
map     [1;5B     <C-Down>
map!    [1;5B     <C-Down>
map     [1;5C     <C-Right>
map!    [1;5C     <C-Right>
map     [1;5D     <C-Left>
map!    [1;5D     <C-Left>

map     [1;6A     <C-S-Up>
map!    [1;6A     <C-S-Up>
map     [1;6B     <C-S-Down>
map!    [1;6B     <C-S-Down>
map     [1;6C     <C-S-Right>
map!    [1;6C     <C-S-Right>
map     [1;6D     <C-S-Left>
map!    [1;6D     <C-S-Left>

map     [1;3A     <M-Up>
map!    [1;3A     <M-Up>
map     [1;3B     <M-Down>
map!    [1;3B     <M-Down>
map     [1;3C     <M-Right>
map!    [1;3C     <M-Right>
map     [1;3D     <M-Left>
map!    [1;3D     <M-Left>

map     [5~       <PageUp>
map!    [5~       <PageUp>
map     [5;2~     <S-PageUp>
map!    [5;2~     <S-PageUp>
map     [5;5~     <C-PageUp>
map!    [5;5~     <C-PageUp>
map     [5;6~     <C-S-PageUp>
map!    [5;6~     <C-S-PageUp>
map     [6~       <PageDown>
map!    [6~       <PageDown>
map     [6;2~     <S-PageDown>
map!    [6;2~     <S-PageDown>
map     [6;5~     <C-PageDown>
map!    [6;5~     <C-PageDown>
map     [6;6~     <C-S-PageDown>
map!    [6;6~     <C-S-PageDown>

map     d         <M-d>
map!    d         <M-d>
map             <M-BS>
map!            <M-BS>

" map     [1;5I     <C-Tab>
" map     [1;5I     <C-Tab>
" map!    [1;6I     <C-S-Tab>
" map!    [1;6I     <C-S-Tab>

" if has('osx')
if has('unix')      " Applies to linux and macOS
  map     a         <M-a>
  map!    a         <M-a>
  map     b         <M-b>
  map!    b         <M-b>
  map     c         <M-c>
  map!    c         <M-c>
  map     d         <M-d>
  map!    d         <M-d>
  map     e         <M-e>
  map!    e         <M-e>
  map     f         <M-f>
  map!    f         <M-f>
  map     g         <M-g>
  map!    g         <M-g>
  map     h         <M-h>
  map!    h         <M-h>
  map     i         <M-i>
  map!    i         <M-i>
  map     j         <M-j>
  map!    j         <M-j>
  map     k         <M-k>
  map!    k         <M-k>
  map     l         <M-l>
  map!    l         <M-l>
  map     m         <M-m>
  map!    m         <M-m>
  map     n         <M-n>
  map!    n         <M-n>
  map     o         <M-o>
  map!    o         <M-o>
  map     p         <M-p>
  map!    p         <M-p>
  map     q         <M-q>
  map!    q         <M-q>
  map     r         <M-r>
  map!    r         <M-r>
  map     s         <M-s>
  map!    s         <M-s>
  map     t         <M-t>
  map!    t         <M-t>
  map     u         <M-u>
  map!    u         <M-u>
  map     v         <M-v>
  map!    v         <M-v>
  map     w         <M-w>
  map!    w         <M-w>
  map     x         <M-x>
  map!    x         <M-x>
  map     y         <M-y>
  map!    y         <M-y>
  map     z         <M-z>
  map!    z         <M-z>
  map     A         <M-A>
  map!    A         <M-A>
  map     B         <M-B>
  map!    B         <M-B>
  map     C         <M-C>
  map!    C         <M-C>
  map     D         <M-D>
  map!    D         <M-D>
  map     E         <M-E>
  map!    E         <M-E>
  map     F         <M-F>
  map!    F         <M-F>
  map     G         <M-G>
  map!    G         <M-G>
  map     H         <M-H>
  map!    H         <M-H>
  map     I         <M-I>
  map!    I         <M-I>
  map     J         <M-J>
  map!    J         <M-J>
  map     K         <M-K>
  map!    K         <M-K>
  map     L         <M-L>
  map!    L         <M-L>
  map     M         <M-M>
  map!    M         <M-M>
  map     N         <M-N>
  map!    N         <M-N>
  " Enabling <M-O> cause malfunction of the cursor keys.
  " map     O         <M-O>
  " map!    O         <M-O>
  map     P         <M-P>
  map!    P         <M-P>
  map     Q         <M-Q>
  map!    Q         <M-Q>
  map     R         <M-R>
  map!    R         <M-R>
  map     S         <M-S>
  map!    S         <M-S>
  map     T         <M-T>
  map!    T         <M-T>
  map     U         <M-U>
  map!    U         <M-U>
  map     V         <M-V>
  map!    V         <M-V>
  map     W         <M-W>
  map!    W         <M-W>
  map     X         <M-X>
  map!    X         <M-X>
  map     Y         <M-Y>
  map!    Y         <M-Y>
  map     Z         <M-Z>
  map!    Z         <M-Z>
  map     1         <M-1>
  map!    1         <M-1>
  map     2         <M-2>
  map!    2         <M-2>
  map     3         <M-3>
  map!    3         <M-3>
  map     4         <M-4>
  map!    4         <M-4>
  map     5         <M-5>
  map!    5         <M-5>
  map     6         <M-6>
  map!    6         <M-6>
  map     7         <M-7>
  map!    7         <M-7>
  map     8         <M-8>
  map!    8         <M-8>
  map     9         <M-9>
  map!    9         <M-9>
  map     0         <M-0>
  map!    0         <M-0>
  map     !         <M-!>
  map!    !         <M-!>
  map     @         <M-@>
  map!    @         <M-@>
  map     #         <M-#>
  map!    #         <M-#>
  map     $         <M-$>
  map!    $         <M-$>
  map     %         <M-%>
  map!    %         <M-%>
  map     ^         <M-^>
  map!    ^         <M-^>
  map     &         <M-&>
  map!    &         <M-&>
  map     *         <M-*>
  map!    *         <M-*>
  map     (         <M-(>
  map!    (         <M-(>
  map     )         <M-)>
  map!    )         <M-)>
  map     `         <M-`>
  map!    `         <M-`>
  map     ~         <M-~>
  map!    ~         <M-~>
  map     -         <M-->
  map!    -         <M-->
  map     _         <M-_>
  map!    _         <M-_>
  map     =         <M-=>
  map!    =         <M-=>
  map     +         <M-+>
  map!    +         <M-+>
  map     ;         <M-;>
  map!    ;         <M-;>
  map     :         <M-:>
  map!    :         <M-:>
  map     '         <M-'>
  map!    '         <M-'>
  " map     "         <M-">
  " map!    "         <M-">
  map     ,         <M-,>
  map!    ,         <M-,>
  " map     <         <M-<>
  " map!    <         <M-<>
  map     .         <M-.>
  map!    .         <M-.>
  " map     >         <M->>
  " map!    >         <M->>
  map     /         <M-/>
  map!    /         <M-/>
  map     ?         <M-?>
  map!    ?         <M-?>
  map     \         <M-\>
  map!    \         <M-\>
  " map     |         <M-|>
  " map!    |         <M-|>
endif

