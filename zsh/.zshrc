### Prompt ###

### Default UMASK (clear group, other permissions) ###
umask 077

### Non-interactive shells ###
[[ -z "$PS1" ]] && return

### Alias colors from: http://www.understudy.net/custom.html ###
# Foreground
black=%{$'\e[0;30m'%}
red=%{$'\e[0;31m'%}
green=%{$'\e[0;32m'%}
yellow=%{$'\e[0;33m'%}
blue=%{$'\e[0;34m'%}
purple=%{$'\e[0;35m'%}
cyan=%{$'\e[0;36m'%}
gray=%{$'\e[0;37m'%}

light_black=%{$'\e[1;30m'%}
light_red=%{$'\e[1;31m'%}
light_green=%{$'\e[1;32m'%}
light_yellow=%{$'\e[1;33m'%}
light_blue=%{$'\e[1;34m'%}
light_purple=%{$'\e[1;35m'%}
light_cyan=%{$'\e[1;36m'%}
light_gray=%{$'\e[1;37m'%}

# Background
bg_red=%{$'\e[0;41m'%}
bg_green=%{$'\e[0;42m'%}
bg_brown=%{$'\e[0;43m'%}
bg_blue=%{$'\e[0;44m'%}
bg_purple=%{$'\e[0;45m'%}
bg_cyan=%{$'\e[0;46m'%}
bg_gray=%{$'\e[0;47m'%}

# Attributes
normal=%{$'\e[0m'%}
nodisplay=%{$'\e[8m'%}
reversecolors=%{$'\e[7m'%}
reversecolorsoff=%{$'\e[27m'%}

# Format prompt is [user@host:relative_path]$       ...       timestamp
PROMPT="${at_normal}%(!.#.$) " # Left
RPROMPT="[${<<<<PATH COLOR>>>>}%~${normal}:${<<<<USER COLOR>>>>}%n${normal}@${<<<<HOST COLOR>>>>}%m${normal} %*]" # Right

### History settings ###
export HISTFILE=~/.zsh/history  # Location
export HISTSIZE=100000          # Maximum events
export SAVEHIST=100000          # Maximum unique events
setopt extendedhistory          # With timestamps
setopt INC_APPEND_HISTORY       # Write history to file incrementally, not on exit
setopt HIST_IGNORE_ALL_DUPS     # Remove older duplicate command for new one
setopt HIST_IGNORE_SPACE        # Don't save commands with leading space
setopt HIST_REDUCE_BLANKS       # Trim superfluous whitespace from history
setopt HIST_VERIFY              # Expand '!' history expansion before submit

### tab completion ###
setopt AUTO_LIST                # List choices for tab completion
setopt AUTO_MENU                # After showing list, rotate through
# setopt AUTO_LIST AUTO_MENU    # Overides AUTO_MENU. Jump to first match automatically

# Constrain completion list by command with regex
compctl -g '*.java' + -g '*(-/)' javac                                  # javac only .java files
compctl -g '*.c' + -g '*(-/)' gcc                                       # gcc only .c files
compctl -g '*.gz' + -g '*(-/)' gunzip gzcat                             # extract only .gz files
compctl -g '*(-/) .*(-/)' cd                                            # cd only to directories
#compctl -g '(^(*.o|*.class|*.jar|*.gz|*.gif|*.a|*.Z))' more less vim    # don't read binary files

### editor = vim ###
if [[ -x $(which vim) ]];
then
    export EDITOR="vim"
    export USE_EDITOR=$EDITOR
    export VISUAL=$EDITOR
fi
# bindkey -e            # Use emacs zsh bindings instead of vi

### MISC ###
export REPORTTIME=30    # Time long commands
setopt RM_STAR_WAIT     # Prompt on rm * 
setopt AUTO_CONTINUE    # Persist background tasks on exit

# Watch other users login/out
watch=notme             
export LOGCHECK=60

### Aliases ###
alias 'mkdir=mkdir -p'  # Make directories as needed
alias 'ls=ls <<<<LS COLOR PARAMETER>>>>'   # ls color output

### PATH ###
# Python
export PYTHONPATH="$PYTHONPATH"

# ~/bin scripts
if [ -d $HOME/bin ]; then
    export PATH="$HOME/bin:$PATH"
fi

### screen auto-title/shelltitle functions ###
# if using GNU screen, let the zsh tell screen what the title and hardstatus
# of the tab window should be.
if [[ $TERM == "screen" ]]; then
  _GET_PATH='echo $PWD | sed "s/^\/Users\//~/;s/^~$USER/~/"'

  # use the current user as the prefix of the current tab title (since that's
  # fairly important, and I change it fairly often)
  #TAB_TITLE_PREFIX='"`'$_GET_PATH' | sed "s:..*/::"`$PROMPT_CHAR"'
  # when at the shell prompt, show a truncated version of the current path (with
  # standard ~ replacement) as the rest of the title.
  TAB_TITLE_PROMPT='$SHELL:t'
  # when running a command, show the title of the command as the rest of the
  # title (truncate to drop the path to the command)
  TAB_TITLE_EXEC='$cmd[1]:t'

  # use the current path (with standard ~ replacement) in square brackets as the
  # prefix of the tab window hardstatus.
  TAB_HARDSTATUS_PREFIX='"[`'$_GET_PATH'`] "'
  # when at the shell prompt, use the shell name (truncated to remove the path to
  # the shell) as the rest of the title
  TAB_HARDSTATUS_PROMPT='$SHELL:t'
  # when running a command, show the command name and arguments as the rest of
  # the title
  TAB_HARDSTATUS_EXEC='$cmd'

  # tell GNU screen what the tab window title ($1) and the hardstatus($2) should be
  function screen_set(){
    # set the tab window title (%t) for screen
    print -nR $'\033k'$1$'\033'\\\

    # set hardstatus of tab window (%h) for screen
    print -nR $'\033]0;'$2$'\a'
  }
  # called by zsh before executing a command
  function preexec(){
    local -a cmd; cmd=(${(z)1}) # the command string
    eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_EXEC"
    eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_EXEC"
    screen_set $tab_title $tab_hardstatus
  }
  # called by zsh before showing the prompt
  function precmd(){
    eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_PROMPT"
    eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_PROMPT"
    screen_set $tab_title $tab_hardstatus
  }
fi

