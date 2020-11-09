"=============================================================================
" scala.vim --- SpaceVim lang#scala layer
" Copyright (c) 2020 Jim Miller
" Author: Jim Miller < miller.jimd at gmail.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================
scriptencoding utf-8


""
" @section lang#scala, layer-lang-scala
" @parentsection layers
" This layer is for Scala development.
"
" @subsection Mappings
" >
"   Import key bindings:
"
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    <F4>          show candidates for importing of cursor symbol
"   insert    <F4>          show candidates for importing of cursor symbol
"   normal    SPC l i c     show candidates for importing of cursor symbol
"   normal    SPC l i q     prompt for a qualified import
"   normal    SPC l i o     organize imports of current file
"   normal    SPC l i s     sort imports of current file
"   insert    <c-;>i        prompt for a qualified import
"   insert    <c-;>o        organize imports of current file
"   insert    <c-;>s        sort imports of current file
"
"   Debug key bindings:
"
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    SPC l d t     show debug stack trace of current frame
"   normal    SPC l d c     continue the execution
"   normal    SPC l d b     set a breakpoint for the current line
"   normal    SPC l d B     clear all breakpoints
"   normal    SPC l d l     launching debugger
"   normal    SPC l d i     step into next statement
"   normal    SPC l d o     step over next statement
"   normal    SPC l d O     step out of current function
"
"   Sbt key bindings:
"
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    SPC l b c     sbt clean compile
"   normal    SPC l b r     sbt run
"   normal    SPC l b t     sbt test
"   normal    SPC l b p     sbt package
"   normal    SPC l b d     sbt show project dependencies tree
"   normal    SPC l b l     sbt reload project build definition
"   normal    SPC l b u     sbt update external dependencies
"   normal    SPC l b e     run sbt to generate .ensime config file
"
"   Execute key bindings:
"
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    SPC l r       run main class
"
"   REPL key bindings:
"
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    SPC l s i     start a scala inferior REPL process
"   normal    SPC l s b     send buffer and keep code buffer focused
"   normal    SPC l s l     send line and keep code buffer focused
"   normal    SPC l s s     send selection text and keep code buffer focused
"
"   Other key bindings:
"
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    SPC l Q       bootstrap server when first-time-use
"   normal    SPC l h       show Documentation of cursor symbol
"   normal    SPC l n       inline local refactoring of cursor symbol
"   normal    SPC l e       rename cursor symbol
"   normal    SPC l g       find Definition of cursor symbol
"   normal    SPC l t       show Type of expression of cursor symbol
"   normal    SPC l p       show Hierarchical view of a package
"   normal    SPC l u       find Usages of cursor symbol
"
" <
" SpaceVim uses [`ensime-vim`](http://ensime.github.io/editors/vim/install/)
" to provide code completion, format, sort imports etc, if has python support.
" Also you can enable lsp layer to has a better experience.
"
"
" @subsection language server `metals-vim`
"
" Right now `metals-vim` works with `coc.nvim` to offer a richer user experience 
" than other servers(LanguageClient-neovim or vim-lsp). Please make sure that
" `metals-vim` executable is in your `system $PATH`. Installation guide is here:
" [`metals-vim`](https://scalameta.org/metals/docs/editors/vim.html)
"
"
" @subsection Ensime-vim setup steps
"
" The following is quick install steps, if you want to see complete details,
" please see: [`ensime-vim`](http://ensime.github.io/editors/vim/install/)
"
" 1. Install vim`s plugin and its dependencies as following.
"
"      `pip install websocket-client sexpdata`,
"
"      `pip install pynvim` (neovim only).
"
" 2. Integration ENSIME with your build tools, here we use sbt.
"    add (sbt-ensime) as global plugin for sbt:
"    Put code `addSbtPlugin("org.ensime" % "sbt-ensime" % "2.6.1")` in file 
"    '~/.sbt/plugins/plugins.sbt' (create if not exists).
"    Armed with your build tool plugin, generate the `.ensime` config file from
"    your project directory in command line, e.g. for sbt use `sbt ensimeConfig`,
"    or `./gradlew ensime` for Gradle. the first time will take several minutes.
"
" 3. The first time you use ensime-vim (per Scala version), it will `bootstrap` the
"    ENSIME server installation when opening a Scala file you will be prompted to
"    run |:EnInstall|. Do that and give it a minute or two to run.
"    After this, you should see reports in Vim's message area that ENSIME is coming
"    up, and the indexer and analyzer are ready.
"    Going forward, ensime-vim will automatically start the ENSIME server when you
"    edit Scala files in a project with an `.ensime` config present.
"
"
" @subsection Code formatting
"
" 1.  To make neoformat support scala file, you should install scalariform.
"     [`scalariform`](https://github.com/scala-ide/scalariform)
"     and set 'g:spacevim_layer_lang_scala_formatter' to the path of the jar.
"
" 2.  If lsp [`metals-vim`](https://scalameta.org/metals/docs/editors/overview.html)
"     is enabled, it will automatically use 
"     [`scalafmt`](https://scalameta.org/scalafmt/docs/configuration.html) 
"     to format code.


function! SpaceVim#layers#lang#scala#config() abort
  call SpaceVim#mapping#space#regesit_lang_mappings('scala', function('s:language_specified_mappings'))
  call SpaceVim#plugins#repl#reg('scala', 'scala')
  call add(g:spacevim_project_rooter_patterns, 'build.sbt')
  augroup SpaceVim_lang_scala
    au!
    au BufRead,BufNewFile *.sbt,*sc set filetype=scala
  augroup END

endfunction

function! s:language_specified_mappings() abort

  nnoremap <silent><buffer> K :call SpaceVim#lsp#show_doc()<CR>
  nmap <Leader>ws <Plug>(coc-metals-expand-decoration)
  call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'd'],
        \ 'call SpaceVim#lsp#show_doc()', 'show Document', 1)
  call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'e'],
        \ 'call SpaceVim#lsp#rename()()', 'rename Symbol', 1)
  call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'g'],
        \ 'call SpaceVim#lsp#go_to_def()', 'goto Definition', 1)
  call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'u'],
        \ 'call SpaceVim#lsp#references()', 'find References', 1)
  call SpaceVim#mapping#space#langSPC('nnoremap', ['l', 'u'],
        \ 'call SpaceVim#lsp#references()', 'find References', 1)
  call SpaceVim#mapping#space#langSPC('nnoremap', ['e', 'l'],
        \ 'CocList diagnostics', 'list Diagnostics', 1)

  " code runner
  call SpaceVim#mapping#space#langSPC('nmap', ['l','r'],
        \ 'call SpaceVim#plugins#runner#open()', 'execute current file', 1)

  " REPL
endfunction

" vim:set et sw=2 cc=80:
