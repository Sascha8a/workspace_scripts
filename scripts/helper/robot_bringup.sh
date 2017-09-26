#!/bin/sh

_robot_bringup_include()
{
    dir="$1"
    shift
    for FILE in $dir; do
        if [ ! -r $FILE ]; then continue; fi
        echo "Including $FILE..." >/dev/null
        source $FILE
    done
}

_robot_bringup_run()
{
    dir="$1"
    shift
    for FILE in $dir; do
        if [ ! -x $FILE ]; then continue; fi
        echo "Running $FILE..." >/dev/null
        $FILE "$@"
    done
}

wait_for_roscore()
{
    until rostopic list &>/dev/null ; do sleep 1; done
}
