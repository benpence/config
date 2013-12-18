#!/bin/sh

DEST="~"
mkDirectory(){
    local directory=$1 && shift;

    echo mkdir -p "$directory";
    mkdir      -p "$directory";
    return $?
}

COMMENT_REGEX="^(((\ +)?\#)|((\ +))|$)"
isComment(){
    [[ "$1" =~ $COMMENT_REGEX ]]
    return $?
}

createDirectories(){
    local directories=$1 && shift;

    cat "$directories" | while read d; do
        isComment "$d" && continue

        mkDirectory "$DEST/$d" || exit 1;
    done;
}

copyFiles(){
    local files=$1 && shift;

    cat "$files" | while read f; do
        isComment "$f" && continue

        local containing_dir=`dirname $f`
        mkDirectory "$DEST/${containing_dir}" || exit 1;

        echo cp -Ra "home/$f" "$DEST/$f"
        cp      -Ra "home/$f" "$DEST/$f" || exit 1;
    done;
}

usage(){
    echo $0 DIRECTORIES_FILE FILES_FILE
}

if [[ $# -eq 2 ]] && [[ -r "$1" ]] && [[ -r "$2" ]]; then
    createDirectories $1;
    copyFiles $2;
else
    usage
    exit 1
fi
