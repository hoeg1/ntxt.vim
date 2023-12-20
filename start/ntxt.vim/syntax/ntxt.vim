if exists("b:current_syntax")
  finish
endif

" タイトルの指定：　行頭が＃で、改行まで
syn region nSharp start=/^[#＃]/ end=/$/
highlight def link nSharp Title

" コメント文：　行頭が※で始まって改行までとする
syn region nComment start=/^※/ end=/$/
highlight def link nComment Comment

" ルビと傍点には｜を必須とする
" 汎用性を考え、カクヨム形式の《《傍点対象》》は使わない
syn region String matchgroup=NonText start=/[|｜]/ end=/《[^《》|｜]\+》/ contains=Comment

" 半角スペースを警告
syn match hanSp /\s\+/
hi def link hanSp SpellBad

" なろう形式の「漢字（かんじ）」をルビとするパターンは
" 予想外の動作を生みがちなので、警告表示する
syn match ngKakko /[\u4E00-\u9FFF\u3005-\u3007]\+[(（][ぁ-んァ-ヶ]\+[)）]/
hi def link ngKakko SpellBad


" flag
let b:current_syntax="ntxt"

