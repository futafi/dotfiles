set completefunc=emoji#complete
command EmojiUnicode %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g
