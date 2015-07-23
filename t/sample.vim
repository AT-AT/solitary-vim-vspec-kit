" Load common helpers.
execute 'source ' . expand('%:p:h') . '/t/_common/test_helpers.vim'

" MUST load start-up file in plugin directroy.
runtime! plugin/xxx.vim

" Tell vspec-vim to use functions for accessing script local variables and functions.
call vspec#hint({'scope': 'xxx#scope()', 'sid': 'xxx#sid()'})
"
" Note: scope() and sid() function is like as below.
"
" function! xxx#sid()
"   return maparg('<SID>', 'n')
" endfunction
"
" nnoremap <SID>  <SID>
" function! xxx#scope()
"   return s:
" endfunction



" Define script local functions that wrap common helpers with script specific parameters if needed.
" (see common helpers for more details)
function! s:Reg(subject)
  return _Reg_('__t__', a:subject)
endfunction

function! s:StashGlobal(subject)
  let subject = a:subject != 0 ? 'PREFIX_OF_GLOBAL_VARIABLES_FOR_THIS_PLUGIN' : 0
  call _Stash_(subject)
endfunction

function! s:Local(subject)
  return _HandleLocalDict_('s:SCRIPT_LOCAL_VARIABLE_NAME', a:subject)
endfunction

" Define script local helpers if needed.
function! s:foo_helper()
  " something to do.
endfunction


" Define test.
describe 'foo'

  before
  end

  after
  end
  
  context 'bar'

    it 'should be true'
      Expect 1 to_be_true
    end

  end

  context 'baz'

    it 'should be false'
      Expect 0 to_be_false
    end
  end

end

