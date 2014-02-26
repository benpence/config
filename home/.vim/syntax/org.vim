" For folding
" syn region orgFirst    start=/^[^ ]/          end=/^[^ ]\@=/               transparent contains=orgFirstLine  fold
" syn region orgFirst    start=/^\* /           end=/^\(\* \)\@=/            transparent contains=orgFirstLine  fold
" syn region orgSecond   start=/^  [^ ]/        end=/^\(  [^ ]\)\@=/         transparent contains=orgSecondLine fold
" syn region orgSecond   start=/^\*\* /         end=/^\(\*\* \)\@=/          transparent contains=orgSecondLine fold
" syn region orgThird    start=/^    [^ ]/      end=/^\(    [^ ]\)\@=/       transparent contains=orgThirdLine  fold
" syn region orgThird    start=/^\*\*\* /       end=/^\(\*\*\* \)\@=/        transparent contains=orgThirdLine  fold
" syn region orgFourth   start=/^      [^ ]/    end=/^\(      [^ ]\)\@=/     transparent contains=orgFourthLine fold
" syn region orgFourth   start=/^\*\*\*\* /     end=/^\(\*\*\*\* \)\@=/      transparent contains=orgFourthLine fold
" syn region orgFifth    start=/^        [^ ]/  end=/^\(        [^ ]\)\@=/   transparent contains=orgFifthLine  fold
" syn region orgFifth    start=/^\*\*\*\*\* /   end=/^\(\*\*\*\*\* \)\@=/    transparent contains=orgFifthLine  fold

syn match orgFirstLine  /^[^ ].*/           display contains=orgTag,orgLink,orgDate
syn match orgSecondLine /^  [^ ].*/         display contains=orgTag,orgLink,orgDate
syn match orgThirdLine  /^    [^ ].*/       display contains=orgTag,orgLink,orgDate
syn match orgFourthLine /^      [^ ].*/     display contains=orgTag,orgLink,orgDate
syn match orgFifthLine  /^        [^ ].*/   display contains=orgTag,orgLink,orgDate
syn match orgEtcLine    /^          .*/     display contains=orgTag,orgLink,orgDate
syn match orgFirstLine  /^\* .*/            display contains=orgTag,orgLink,orgDate
syn match orgSecondLine /^\*\* .*/          display contains=orgTag,orgLink,orgDate
syn match orgThirdLine  /^\*\*\* .*/        display contains=orgTag,orgLink,orgDate
syn match orgFourthLine /^\*\*\*\* .*/      display contains=orgTag,orgLink,orgDate
syn match orgFifthLine  /^\*\*\*\*\* .*/    display contains=orgTag,orgLink,orgDate
syn match orgEtcLine    /^\*\*\*\*\*\*.*/   display contains=orgTag,orgLink,orgDate

syn match orgTag        /\#\S\+/            contained
syn match orgLink       /https\?\:\/\/\S\+/ contained
syn match orgDate       /\[[^\]]\+\]/       contained

hi def link orgFirstLine    Identifier
hi def link orgSecondLine   Statement
hi def link orgThirdLine    String
hi def link orgFourthLine   Comment
hi def link orgFifthLine    PreProc
hi def link orgEtcLine      Special

hi def link orgTag          Normal
hi def link orgLink         Underlined
hi def link orgDate         Normal

if !exists('b:current_syntax')
  let b:current_syntax = 'org'
endif
