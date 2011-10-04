#!/bin/bash
help__() { 
        echo 
        echo "Web BackDoor Finder Light."
	echo "This script will help you find backdoor inside your WebApplication at Filesystem level."
	echo
	echo "USAGE: ${0} directory 'filename'"
	echo "Example: ${0} ./ '*.php'" 
}

: ${1? "Dir missing $(help__)"}
: ${2? "filename missing $(help__)"}

DIR=$1
name=$2

find $DIR -name "$2" -exec awk -v filename={} '{
                                        if ( $0 ~ /([\s]+|=|&|@|^)(system|passthru|exec|popen|shell_exec|proc_open)[\s]*\(/ )
                                                print "command exec - "filename": "count" - "$0

                                        if ( $0 ~ /(base64_decode|base64_encode)[\s]*\(/ )
                                                print "base64 -"filename": "count" - "$0

                                        if ( $0 ~ /([\s]+|=|&|@|^)(eval)[\s]*\(/ )
                                                print "php exec - "filename": "count" - "$0

                                        count++
                                }' {} \;

