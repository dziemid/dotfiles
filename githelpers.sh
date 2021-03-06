#!/bin/bash
 
# An improved (although heavily obfuscated) version of @garybernhardt's
# git pretty log, show in Destroy All Software №63. Said improvements are:
#
# * Minimize the whitespace between the columns - use a single space instead
#   of whatever the color codes require
# * Colorize the graph, as with git log --graph
# * Slightly simplify the sed regular expression
#
# On the downside, it ends up with a two monstrous and fairly obscure awk
# scripts that do the heavy lifting. It could have been way simpler, if
# the column utility was not that stupid. It could have been replaces with
# awk, but that in itself is a daunting task, since the common subset of
# the awk implementations on Mac OS X and Linux is poor.
#
# You can see the difference here: http://cl.ly/1j312d2z3x1e1O2Z3W3T
 
HASH="%C(yellow)%h%C(reset)"
RELATIVE_TIME="%C(green)(%ar)%C(reset)"
AUTHOR="%C(bold blue)<%an>%C(reset)"
REFS="%C(red)%d%C(reset)"
SUBJECT="%s"
 
FORMAT="$HASH}$RELATIVE_TIME<time>}$AUTHOR<author>}$REFS $SUBJECT"
 
gitl() {
    git log --color --graph --abbrev-commit --date=relative --pretty="tformat:${FORMAT}" $* |
        sed -E -e 's/\(([[:digit:]]+) ([[:alpha:]]+).* ago\)/(\1 \2)/' |
        awk '
          BEGIN { FS = "}"; OFS = "}" }
          function strip(str) {
            gsub(/\x1B\[[0-9;]*[mK]/, "", str)
            return str
          }
          { print $1, "<" strip($1) FS ">" $2, $3, $4 }
        ' |
        column -s '}' -t |
        awk '{
          match($0, /<[^>]*>/)
          stripped = substr($0, RSTART + 1, RLENGTH - 2)
          graph    = substr($0, 1, RSTART - 1)
          line     = substr($0, RSTART + RLENGTH)
 
          match(stripped, / *$/)
          trailing_spaces = RLENGTH
 
          match(graph, / *$/)
          graph = substr(graph, 1, RSTART + trailing_spaces - 2)
 
          sub(/<time> /, "", line)
          sub(/<author>  /, "", line)
 
          print graph line
        }' |
        less -FXRS
}
