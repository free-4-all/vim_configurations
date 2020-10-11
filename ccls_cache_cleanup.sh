#/bin/bash

declare -a FILES
MAX_FILE_AGE=7 #delete files older than this.
#CCLS_CACHE_DIRS=(`find ~/repos/tb ~/as ~/workspaces -type d -iname .ccls-cache -print`)
CCLS_CACHE_DIRS=(`find ~/ -type d -iname .ccls-cache -print`)
echo "CCLS CACHE DIRS: " $CCLS_CACHE_DIRS

for CCLS_CACHE_DIR in "${CCLS_CACHE_DIRS[@]}"
do
    initialize_variables()
    log("Compile commands file:", $COMPILE_COMMANDS_FILE)

    delete_dir_if_missing_required_files()
    CURRENT_TIME=get_current_time()
    LAST_MODIFIED_TIME=get_last_modified_time()
    
    log("Current Unix Time: ", $CURRENT_TIME)
    log("Last modified Unix Time: ", $LAST_MODIFIED_TIME)
    TIME_DELTA=get_time_delta($CURRENT_TIME, $LAST_MODIFIED_TIME)


    DIRNAME=`dirname $CCLS_CACHE_DIR`
    BASENAME=`basename $CCLS_CACHE_DIR`
    COMPILE_COMMANDS_FILE=$DIRNAME/compile_commands.json

    echo Compile commands file: $COMPILE_COMMANDS_FILE
    if [ ! -f $COMPILE_COMMANDS_FILE ]; then
        echo deleting $CCLS_CACHE_DIR, as compile_comamands.json does not exist!
        #delete CCLS_CACHE_DIR
        rm -r $CCLS_CACHE_DIR
        printf '\n'
        printf '\n'
        continue
    fi
    CURRENT_TIME=$(date +%s)
    FILE_LAST_MODIFIED_TIME=$(stat -c %Y $COMPILE_COMMANDS_FILE)
    echo Current Unix Time: $(date)
    echo Last Edited Unix Time '(file: '$COMPILE_COMMANDS_FILE')'
    echo $FILE_LAST_MODIFIED_TIME
    TIME_DELTA=`expr $CURRENT_TIME - $FILE_LAST_MODIFIED_TIME`
    MINS=`expr $TIME_DELTA / 60`
    DAYS=`expr $MINS / 1440`
    echo We Last Edited This File $DAYS days Ago
    if (($DAYS > $MAX_FILE_AGE))  ; then
        echo deleting $CCLS_CACHE_DIR, as compile_commands.json is $DAYS days old,  older than allowed age of $MAX_FILE_AGE.
        #delete CCLS_CACHE_DIR
        rm -r $CCLS_CACHE_DIR
    else 
        echo File is still too young '('$DAYS' days)', not deleting $CCLS_CACHE_DIR.
    fi
    printf '\n'
    printf '\n'
done
#function to delete ccls cache directory...
