let g:vebugger_use_tags=1 " Lets jdb use tags to find source files
let g:vebugger_leader='<Leader>d'
"KEYMAPS 
"i      |:VBGstepIn|
"o      |:VBGstepOver|
"O      |:VBGstepOut|
"c      |:VBGcontinue|
"
"b      |:VBGtoggleBreakpointThisLine|
"B      |:VBGclearBreakpoints|
"
"e      |:VBGevalWordUnderCursor| in normal mode
"       |:VBGevalSelectedText| in select mode
"E      Prompt for an argument for |:VBGeval|
"
"x      |:VBGexecute| current line in normal mode.
"       |:VBGexecuteSelectedText| in select mode
"X      Prompt for an argument for |:VBGexecute|
"
"t      |:VBGtoggleTerminalBuffer|
"r      Select mode only - |:VBGrawWriteSelectedText|
"R Prompt for an argument for |:VBGrawWrite|
