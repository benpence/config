### Prompt ###
### Non-interactive shells ###
[[ -z "$PS1" ]] && return

# Load colors module
autoload colors zsh/terminfo
if [[ "terminfo[colors]" -ge 8 ]]; then
    colors
fi

# Alias colors
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'

    (( count = $count + 1 ))
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

# Format prompt is [user@host:relative_path]$       ...       timestamp
PS1="[$PR_MAGENTA%n$PR_NO_COLOR@$PR_YELLOW%m$PR_NO_COLOR:$PR_CYAN%~ $PR_GREEN%h$PR_NO_COLOR]%(!.#.$) " # Left
RPS1="$PR_WHITE%B%*%b" # Right


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

### editor = vim ###
if [[ -x $(which vim) ]]
then
    export EDITOR="vim"
    export USE_EDITOR=$EDITOR
    export VISUAL=$EDITOR
fi


### MISC ###
# Time long commands
export REPORTTIME=30

# Prompt on rm * 
setopt RM_STAR_WAIT

# Persist background tasks on exit
setopt AUTO_CONTINUE

# Watch other users login/out
watch=notme
export LOGCHECK=60

### Aliases ###
alias 'mkdir=mkdir -p'  # Make directories as needed
alias 'ls=ls -G'        # ls color output

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
