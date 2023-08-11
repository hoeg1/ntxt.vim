if exists("b:current_syntax")
  finish
endif

syn region nSharp start=/[#＃]/ end=/$/
highlight def link nSharp Title

syn region nComment start=/^[ 　]*※/ end=/$/
highlight def link nComment Comment

" ルビと傍点には｜を必須とする
" 汎用性を考え、カクヨム形式の《《傍点対象》》は使わない
syn region nRubySE matchgroup=nRuby start=/[|｜]/ end=/《[^《》|｜]\+》/ contains=nRubyVal
hi def link nRuby NonText
hi def link nRubyVal String

" 半角スペースを警告
syn match hanSp /\s\+/
hi def link hanSp SpellBad

" なろう形式の「漢字（かんじ）」をルビとするパターンは
" 予想外の動作を生みがちなので、警告表示する
syn match ngKakko /[\u4E00-\u9FFF\u3005-\u3007]\+[(（][ぁ-んァ-ヶ]\+[)）]/
hi def link ngKakko SpellBad


" flag
let b:current_syntax="ntxt"

