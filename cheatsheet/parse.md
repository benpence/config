# grep

    grep -rl 'string'                   # Filenames of files that contain string (recursive search)
    grep -v 'string'                    # Lines not containing ('-v') string
    egrep -<number> 'regex'             # Lines matching regex and <number> surrounding lines 

# sed

    sed 's/\w\w*//'                     # Remove first word of every line
    sed 's/\w\w*//g'                    # Remove every word of every line
    sed 's/\(\w\w*\) \(\w\w*\)/\1/g'    # Remove even words (and preceding space) of every line

    sed 's/\w\w*//2'                    # Remove second word
    sed 's/\w\w*//2g'                   # Remove words after first word

    sed '/regex/d'                      # Delete lines with a match (egrep -v)
    sed '/^$/d'                         # Delete empty lines

    sed 'expression/w file'             # Write output to file

    sed -e 'expression' -e 'expression' # Run multiple expressions consecutively

    sed '/regex/p'                      # '/p' prints each matching line an additional time
    sed -n '/regex/p'                   # egrep ('-n' blocks normal output, '/p' prints matches)
    sed -n 's/regex/&/p'                # egrep ('-n' blocks normal output, '/p' prints matches)

# awk

    awk 'cond { actions }'                  
    
    # example cond:
    #   1                           true
    #   $1 ~ /regex/                first field matches a regex
    #   /regex/                     line matches a regex
    #   x < 5                       x is less than 5
    #   x % 2 == 0                  x is even
    #   $3 == "banana"              third field is "banana"
    #
    # example actions:
    #                               print line (default when action missing)
    #   print                       print line
    #   print FS, $0                print var FS, var OFS, the line ($0), var ORS (see below)
    #   x = 5                       set var x to 5
    #   x[0] = 5                    set key 0 in array x to 5
    #   x["hungry"]                 set key "hungry" in array x to ""
    #   x++                         increment x
    #   sprintf(s, vals...)         traditional sprintf
    #   getline                     move to next line, continue
    #   next                        move to next line, restart from first cond-action
    #   exit                        stop processing lines
    #   if (cond) action            traditional if statement
    #   while (cond) action         traditional while loop
    #   for (i=0;i<n;i++) action    traditional for loop
    #   for (i in a) action         iterate over array keys in arbitrary order
    #   
    # built-in variables:
    #   NR                          lines processed total
    #   FNR                         lines processed in this file
    #   RS                          line delimiter
    #   ORS                         line join string when printing
    #   NF                          fields in current line
    #   FS                          field delimiter
    #   OFS                         field join string when printing
    #   length                      total characters in line
    #   FILENAME                    file being parsed ('-' for stdin)

    awk 'cond { actions } cond { actions }'         # multiple cond-actions run on same line
    awk 'cond { actions; actions }'                 # multiple actions depend on same cond
    awk 'cond && (cond || !(cond))'                 # cond statements can be negated, anded, ored

    awk 'BEGIN { actions }'                         # actions before processing
    awk 'END   { actions }'                         # actions after processing

    awk ''                                          # Discard input
    awk 'NR > 1 { exit }; 1'                        # Print first line

    awk '{for(i = 1; i < 6; i++) print i; exit}'    # Print numbers 1 to 5
    awk '{x[$0]} END {for (i in x) print i}'        # Store entire input and print its lines in arbitrary order
    
    awk '{ sub(/regex/, "new") } 1'                 # sed 's/regex/new/' (first action affects future actions)
    awk 'BEGIN {RS="[ \t\n]+"}; /[0-9]*9/'          # Print numbers ending in 9
    awk 'NR==FNR {a[$0]; next} $0 in a' f1 f2       # Print lines in f2 that are in f1

    # CREDIT: some commands copied from http://www.catonmat.net/
