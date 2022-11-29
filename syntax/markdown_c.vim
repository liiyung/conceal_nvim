" Vim syntax file
"
" Language: Markdown Concealed Vim Syntax
" Based_On: vim-markdown v9: https://github.com/plasticboy/vim-markdown
" Original_Author: Ben Williams <benw@plasticboy.com>
" Conceal_Mods_and_General_Improvements: Kevin MacMartin <prurigro at gmail dot com>
"

" Read the HTML syntax to start with
if version < 600
    so <sfile>:p:h/html.vim
else
    runtime! syntax/html.vim
    if exists('b:current_syntax')
        unlet b:current_syntax
    endif
endif

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508|command! -nargs=+ HtmlHiLink hi link <args>|else|command! -nargs=+ HtmlHiLink hi def link <args>|endif
    command! -nargs=+ HtmlHiLink hi link <args>
else|command! -nargs=+ HtmlHiLink hi def link <args>|endif
    command! -nargs=+ HtmlHiLink hi def link <args>
endif

syn spell toplevel
syn case ignore
syn sync linebreaks=1

"additions to HTML groups
syn region htmlItalic          matchgroup=mkdDelimiter start="\\\@<!\*\S\@="                          end="\S\@<=\\\@<!\*"                   keepend oneline concealends contains=mkdEscape
syn region htmlItalic          matchgroup=mkdDelimiter start="\(^\|\s\)\@<=_\|\\\@<!_\([^_]\+\s\)\@=" end="\S\@<=_\|_\S\@="                  keepend oneline concealends contains=mkdEscape
syn region htmlBold            matchgroup=mkdDelimiter start="\S\@<=\*\*\|\*\*\S\@="                  end="\S\@<=\*\*\|\*\*\S\@="            keepend oneline concealends contains=mkdEscape
syn region htmlBold            matchgroup=mkdDelimiter start="\S\@<=__\|__\S\@="                      end="\S\@<=__\|__\S\@="                keepend oneline concealends contains=mkdEscape
syn region htmlBoldItalic      matchgroup=mkdDelimiter start="\S\@<=\*\*\*\|\*\*\*\S\@="              end="\S\@<=\*\*\*\|\*\*\*\S\@="        keepend oneline concealends contains=mkdEscape
syn region htmlBoldItalic      matchgroup=mkdDelimiter start="\S\@<=___\|___\S\@="                    end="\S\@<=___\|___\S\@="              keepend oneline concealends contains=mkdEscape
syn region mkdFootnotes        matchgroup=mkdDelimiter start="\[^"                                    end="\]"
syn region mkdID               matchgroup=mkdDelimiter start="\!?\["                                  end="\]"                               contained oneline
syn region mkdURL              matchgroup=mkdDelimiter start="("                                      end=")"                                contained contains=mkdEscape,mkdURLInnerParen oneline
syn match  mkdURLInnerParen                            "([^)]*)"                                                                             contained
syn region mkdLink             matchgroup=mkdDelimiter start="\\\@<!\["                               end="\]\ze\s*[[(]"                     contains=@Spell,mkdEscape nextgroup=mkdURL,mkdID skipwhite oneline concealends cchar=→
syn region mkdLink             matchgroup=mkdDelimiter start="\[\["                                   end="\]\]"                             contains=@Spell,mkdEscape nextgroup=mkdURL,mkdID skipwhite oneline concealends
syn match  mkdInlineURL                                /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
syn region mkdLinkDef          matchgroup=mkdDelimiter start="^ \{,3}\zs\["                           end="]:"                               oneline nextgroup=mkdLinkDefTarget skipwhite
syn region mkdLinkDefTarget                            start="<\?\zs\S" excludenl                     end="\ze[>[:space:]\n]"                contained nextgroup=mkdLinkTitle,mkdLinkDef skipwhite skipnl oneline
syn region mkdLinkTitle        matchgroup=mkdDelimiter start=+"+                                      end=+"+                                contained
syn region mkdLinkTitle        matchgroup=mkdDelimiter start=+'+                                      end=+'+                                contained
syn region mkdLinkTitle        matchgroup=mkdDelimiter start=+(+                                      end=+)+                                contained


"define Markdown groups
syn region mkdMathZone         matchgroup=mkdDelimiter start="\$"                                     end="\$"                               concealends contains=mkdMath
syn match mkdMath                                      "\\"                                                                                  contained conceal
syn match  mkdLineContinue                             ".$"                                                                                  contained
syn match  mkdLineBreak                                /  \+$/
syn region mkdBlockquote                               start=/^\s*>/                                  end=/$/                                contains=mkdLineBreak,mkdLineContinue,@Spell
syn region mkdCode             matchgroup=mkdDelimiter start=/\(\([^\\]\|^\)\\\)\@<!`/                end=/\(\([^\\]\|^\)\\\)\@<!`/          concealends
syn region mkdCode             matchgroup=mkdDelimiter start=/\s*``[^`]*/                             end=/[^`]*``\s*/                       concealends
syn region mkdCode             matchgroup=mkdDelimiter start=/^\s*```.*$/                             end=/^\s*```\s*$/                      concealends contains=mkdCodeCfg
syn match  mkdCodeCfg                                  "{[^}]*}"                                                                             contained conceal
syn region mkdCode             matchgroup=mkdDelimiter start="<pre[^>\\]*>"                           end="</pre>"                           concealends
syn region mkdCode             matchgroup=mkdDelimiter start="<code[^>\\]*>"                          end="</code>"                          concealends
syn region mkdFootnote         matchgroup=mkdDelimiter start="\[^"                                    end="\]"
syn match  mkdCode                                     /^\s*\n\(\(\s\{8,}[^ ]\|\t\t\+[^\t]\).*\n\)\+/
syn match  mkdIndentCode                               /^\s*\n\(\(\s\{4,}[^ ]\|\t\+[^\t]\).*\n\)\+/                                          contained
syn match  mkdListItem                                 "^\s*[-*+]\s\+"                                                                       contains=mkdListTab,mkdListBullet2
syn match  mkdListItem                                 "^\s*\d\+\.\s\+"                                                                      contains=mkdListTab
syn match  mkdListTab                                  "^\s*\*"                                                                              contained contains=mkdListBullet1
syn match  mkdListBullet1                              "\*"                                                                                  contained "conceal cchar=•
syn match  mkdListBullet2                              "[-*+]"                                                                               contained "conceal cchar=•
syn match  mkdChecklist                                "\*\s\[\s\]\s"                                                                     contained conceal cchar=○
syn region mkdNonListItemBlock                         start="\n\(\_^\_$\|\s\{4,}[^ ]\|\t+[^\t]\)\@!" end="^\(\s*\([-*+]\|\d\+\.\)\s\+\)\@=" contains=@mkdNonListItem,@Spell
syn match  mkdRule                                     /^\s*\*\s\{0,1}\*\s\{0,1}\*$/
syn match  mkdRule                                     /^\s*-\s\{0,1}-\s\{0,1}-$/
syn match  mkdRule                                     /^\s*_\s\{0,1}_\s\{0,1}_$/
syn match  mkdRule                                     /^\s*-\{3,}$/
syn match  mkdRule                                     /^\s*\*\{3,5}$/

" HTML headings
syn region htmlH1              matchgroup=mkdDelimiter start="^\s*#"                                  end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
syn region htmlH2              matchgroup=mkdDelimiter start="^\s*##"                                 end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
syn region htmlH3              matchgroup=mkdDelimiter start="^\s*###"                                end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
syn region htmlH4              matchgroup=mkdDelimiter start="^\s*####"                               end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
syn region htmlH5              matchgroup=mkdDelimiter start="^\s*#####"                              end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
syn region htmlH6              matchgroup=mkdDelimiter start="^\s*######"                             end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
syn match  htmlH1                                      /^.\+\n=\+$/                                                                          contains=@Spell
syn match  htmlH2                                      /^.\+\n-\+$/                                                                          contains=@Spell
syn match  mkdEscape                                   "\\[`\*_{}\[\]()#\+-\.\!]"                                                            contained contains=mkdEscapeChar
syn match  mkdEscapeChar                               "\\"                                                                                  contained conceal

syn cluster mkdNonListItem contains=htmlItalic,htmlBold,htmlBoldItalic,mkdFootnotes,mkdID,mkdLink,mkdLinkDef,mkdLineBreak,mkdBlockquote,mkdCode,mkdIndentCode,mkdListItem,mkdRule,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6,mkdEscape

" FUCK YOU YESSSSSSSSSSS
syn match mkdEscapeChar "\\alpha" conceal cchar=α
syn match mkdEscapeChar "\\beta" conceal cchar=β
syn match mkdEscapeChar "\\gamma" conceal cchar=γ
syn match mkdEscapeChar "\\delta" conceal cchar=δ
syn match mkdEscapeChar "\\epsilon" conceal cchar=ε
syn match mkdEscapeChar "\\zeta" conceal cchar=ζ
syn match mkdEscapeChar "\\eta" conceal cchar=η
syn match mkdEscapeChar "\\theta" conceal cchar=θ
syn match mkdEscapeChar "\\iota" conceal cchar=ι
syn match mkdEscapeChar "\\kappa" conceal cchar=κ
syn match mkdEscapeChar "\\lambda" conceal cchar=λ
syn match mkdEscapeChar "\\mu" conceal cchar=μ
syn match mkdEscapeChar "\\nu" conceal cchar=ν
syn match mkdEscapeChar "\\xi" conceal cchar=ξ
syn match mkdEscapeChar "\\omicron" conceal cchar=ο
syn match mkdEscapeChar "\\pi" conceal cchar=π
syn match mkdEscapeChar "\\rho" conceal cchar=ρ
syn match mkdEscapeChar "\\sigma" conceal cchar=σ
syn match mkdEscapeChar "\\tau" conceal cchar=τ
syn match mkdEscapeChar "\\upsilon" conceal cchar=υ
syn match mkdEscapeChar "\\phi" conceal cchar=φ
syn match mkdEscapeChar "\\chi" conceal cchar=χ
syn match mkdEscapeChar "\\psi" conceal cchar=ψ
syn match mkdEscapeChar "\\omega" conceal cchar=ω

" syn match mkdEscapeChar "\Gamma" conceal cchar=Γ
" syn match mkdEscapeChar "\Delta" conceal cchar=Δ
" syn match mkdEscapeChar "\Theta" conceal cchar=Θ
" syn match mkdEscapeChar "\Lambda" conceal cchar=Λ
" syn match mkdEscapeChar "\Xi" conceal cchar=Ξ
" syn match mkdEscapeChar "\Pi" conceal cchar=Π
" syn match mkdEscapeChar "\Sigma" conceal cchar=Σ
" syn match mkdEscapeChar "\Phi" conceal cchar=Φ
" syn match mkdEscapeChar "\Psi" conceal cchar=Ψ
" syn match mkdEscapeChar "\Omega" conceal cchar=Ω

syn match mkdEscapeChar "\\mathbf{A}" conceal cchar=𝐀
syn match mkdEscapeChar "\\mathbf{B}" conceal cchar=𝐁
syn match mkdEscapeChar "\\mathbf{C}" conceal cchar=𝐂
syn match mkdEscapeChar "\\mathbf{D}" conceal cchar=𝐃
syn match mkdEscapeChar "\\mathbf{E}" conceal cchar=𝐄
syn match mkdEscapeChar "\\mathbf{F}" conceal cchar=𝐅
syn match mkdEscapeChar "\\mathbf{G}" conceal cchar=𝐆
syn match mkdEscapeChar "\\mathbf{H}" conceal cchar=𝐇
syn match mkdEscapeChar "\\mathbf{I}" conceal cchar=𝐈
syn match mkdEscapeChar "\\mathbf{J}" conceal cchar=𝐉
syn match mkdEscapeChar "\\mathbf{K}" conceal cchar=𝐊
syn match mkdEscapeChar "\\mathbf{L}" conceal cchar=𝐋
syn match mkdEscapeChar "\\mathbf{M}" conceal cchar=𝐌
syn match mkdEscapeChar "\\mathbf{N}" conceal cchar=𝐍
syn match mkdEscapeChar "\\mathbf{O}" conceal cchar=𝐎
syn match mkdEscapeChar "\\mathbf{P}" conceal cchar=𝐏
syn match mkdEscapeChar "\\mathbf{Q}" conceal cchar=𝐐
syn match mkdEscapeChar "\\mathbf{R}" conceal cchar=𝐑
syn match mkdEscapeChar "\\mathbf{S}" conceal cchar=𝐒
syn match mkdEscapeChar "\\mathbf{T}" conceal cchar=𝐓
syn match mkdEscapeChar "\\mathbf{U}" conceal cchar=𝐔
syn match mkdEscapeChar "\\mathbf{V}" conceal cchar=𝐕
syn match mkdEscapeChar "\\mathbf{W}" conceal cchar=𝐖
syn match mkdEscapeChar "\\mathbf{X}" conceal cchar=𝐗
syn match mkdEscapeChar "\\mathbf{Y}" conceal cchar=𝐘
syn match mkdEscapeChar "\\mathbf{Z}" conceal cchar=𝐙

syn match mkdEscapeChar "\\mathcal{A}" conceal cchar=𝓐
syn match mkdEscapeChar "\\mathcal{B}" conceal cchar=𝓑
syn match mkdEscapeChar "\\mathcal{C}" conceal cchar=𝓒
syn match mkdEscapeChar "\\mathcal{D}" conceal cchar=𝓓
syn match mkdEscapeChar "\\mathcal{E}" conceal cchar=𝓔
syn match mkdEscapeChar "\\mathcal{F}" conceal cchar=𝓕
syn match mkdEscapeChar "\\mathcal{G}" conceal cchar=𝓖
syn match mkdEscapeChar "\\mathcal{H}" conceal cchar=𝓗
syn match mkdEscapeChar "\\mathcal{I}" conceal cchar=𝓘
syn match mkdEscapeChar "\\mathcal{J}" conceal cchar=𝓙
syn match mkdEscapeChar "\\mathcal{K}" conceal cchar=𝓚
syn match mkdEscapeChar "\\mathcal{L}" conceal cchar=𝓛
syn match mkdEscapeChar "\\mathcal{M}" conceal cchar=𝓜
syn match mkdEscapeChar "\\mathcal{N}" conceal cchar=𝓝
syn match mkdEscapeChar "\\mathcal{O}" conceal cchar=𝓞
syn match mkdEscapeChar "\\mathcal{P}" conceal cchar=𝓟
syn match mkdEscapeChar "\\mathcal{Q}" conceal cchar=𝓠
syn match mkdEscapeChar "\\mathcal{R}" conceal cchar=𝓡
syn match mkdEscapeChar "\\mathcal{S}" conceal cchar=𝓢
syn match mkdEscapeChar "\\mathcal{T}" conceal cchar=𝓣
syn match mkdEscapeChar "\\mathcal{U}" conceal cchar=𝓤
syn match mkdEscapeChar "\\mathcal{V}" conceal cchar=𝓥
syn match mkdEscapeChar "\\mathcal{W}" conceal cchar=𝓦
syn match mkdEscapeChar "\\mathcal{X}" conceal cchar=𝓧
syn match mkdEscapeChar "\\mathcal{Y}" conceal cchar=𝓨
syn match mkdEscapeChar "\\mathcal{Z}" conceal cchar=𝓩







" math symbols
syn match mkdEscapeChar "\\frac" contained
syn match mkdEscapeChar "\\left(" conceal cchar=(
syn match mkdEscapeChar "\\right)" conceal cchar=)
syn match mkdEscapeChar "\\left\[" conceal cchar=[
syn match mkdEscapeChar "\\right\]" conceal cchar=]
syn match mkdEscapeChar "\\approx" conceal cchar=≈
syn match mkdEscapeChar "\\equiv" conceal cchar=≡
syn match mkdEscapeChar "\sim" conceal cchar=∼ 
syn match mkdEscapeChar "\\pm" conceal cchar=±
syn match mkdEscapeChar "\\mp" conceal cchar=∓
syn match mkdEscapeChar "\\times" conceal cchar=×
syn match mkdEscapeChar "\\cdot" conceal cchar=·
syn match mkdEscapeChar "\\nabla" conceal cchar=∇
syn match mkdEscapeChar "\\partial" conceal cchar=∂
syn match mkdEscapeChar "\\int" conceal cchar=∫
syn match mkdEscapeChar "\\oint" conceal cchar=∮
syn match mkdEscapeChar "\\sum" conceal cchar=∑
syn match mkdEscapeChar "\\prod" conceal cchar=∏
syn match mkdEscapeChar "\\rightarrow" conceal cchar=→
syn match mkdEscapeChar "\\Rightarrow" conceal cchar=⇒
syn match mkdEscapeChar "\\leftarrow" conceal cchar=←
syn match mkdEscapeChar "\\Leftarrow" conceal cchar=⇐ 
syn match mkdEscapeChar "\\leftrightarrow" conceal cchar=↔
syn match mkdEscapeChar "\\mapsto" conceal cchar=→
syn match mkdEscapeChar "\\downarrow" conceal cchar=↓
syn match mkdEscapeChar "\\Downarrow" conceal cchar=⇓

syn match mkdString "_1" conceal cchar=₁
syn match mkdString "\^2" conceal cchar=²


" syn match mkdMath "^{1}" conceal cchar=¹
" syn match mkdMath "^{5}" conceal cchar=⁵
"
" syn match mkdEscapeChar "\_j" conceal cchar=ⱼ

" Highlighting for Markdown groups
HtmlHiLink mkdString        String
HtmlHiLink mkdCode          String
HtmlHiLink mkdIndentCode    String
HtmlHiLink mkdEscape        Comment
HtmlHiLink mkdEscapeChar    Comment
HtmlHiLink mkdFootnote      Comment
HtmlHiLink mkdBlockquote    Comment
HtmlHiLink mkdLineContinue  Comment
HtmlHiLink mkdDelimiter     Comment
HtmlHiLink mkdListItem      Identifier
HtmlHiLink mkdRule          Identifier
HtmlHiLink mkdLineBreak     Todo
HtmlHiLink mkdFootnotes     htmlLink
HtmlHiLink mkdLink          htmlLink
HtmlHiLink mkdURL           htmlString
HtmlHiLink mkdURLInnerParen mkdURL
HtmlHiLink mkdInlineURL     htmlLink
HtmlHiLink mkdID            Identifier
HtmlHiLink mkdLinkDef       mkdID
HtmlHiLink mkdLinkDefTarget mkdURL
HtmlHiLink mkdLinkTitle     htmlString
HtmlHiLink mkdDelimiter     Delimiter

setlocal formatoptions+=r "Automatically insert bullets
setlocal formatoptions-=c "Do not automatically insert bullets when auto-wrapping with text-width
setlocal comments=b:*,b:+,b:- "Accept various markers as bullets
let b:current_syntax = "markdown_c"
delcommand HtmlHiLink
