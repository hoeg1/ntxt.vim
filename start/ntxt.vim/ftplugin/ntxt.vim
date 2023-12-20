" 執筆用のお助けコマンド

" 原稿用紙換算で何枚になるか
function! s:Genko400()
  " コメントやサブタイメモを消す
  let l:buf_ch = join( map ( getline(0, '$'), "substitute(v:val, '\\(^[ 　]*※\\|[#＃]\\).*$', '','')" ), '')
  " コメントとルビはカウントしない
  let l:buf_ch = substitute(l:buf_ch, '[|｜]\|《[^《》]*》', '', 'g')
  " そんな文字数＝＞全角含む全ての文字を x にして文字数カウント
  let l:buf_ch = substitute(l:buf_ch, '.', 'x', 'g')
  let l:buf_ans = strlen(l:buf_ch)
  " 400字詰めを算出
  let l:buf_400 = printf("%.1f", l:buf_ans / 400.0)
  " １分あたり５００文字読むと仮定した読了目安
  let l:buf_speed = printf("%.0f", round(l:buf_ans / 500.0) )
  " show
  echo l:buf_ans .. '文字, ' .. l:buf_400 .. '枚,  ' .. l:buf_speed .. '分'
endfunction

" コマンド名は Kansan とでもしておく
command! -buffer Kansan :call s:Genko400()

" ルビや傍点をつける。argは呼び出し元のモード
function! s:SetRuby(arg) abort
  if strlen(a:arg)
    " 選択範囲について
    let l:input = input(a:arg .. 'のルビを入力。・なら傍点: ')
    if strlen(l:input)
      let l:out = [a:arg, l:input]
    else
      return a:arg
    endif
  else
    " Inserモード中：あんま使わない
    let l:input = input('漢字 <SP> 読みを入力。無しで傍点: ')
    if strlen(l:input)
      let l:out = split(l:input, '[ 　]\+')
      if len(l:out) == 1
        call add(l:out, '・')
      endif
    else
      " 空文字 '' を返してもよさげ
      return l:out
    endif
  endif
  " 入力がキャンセルされなければ
  if l:out[1] =~ '^・'
    " 指定されたルビがナカグロなら、ターゲットに傍点をつける
    return substitute(l:out[0], '.', '｜\0《・》', 'g')
  else
    return '｜' .. l:out[0] .. '《' .. l:out[1] .. '》'
  endif
endfunction

" <C-j>にマップする
vnoremap <buffer><silent> <C-j> "aygv"_c<C-r>=<SID>SetRuby(@a)<CR>
inoremap <buffer><silent> <C-j> <C-r>=<SID>SetRuby('')<CR>


