#! /bin/bash
if [ $# -eq 0 ]
    then
    echo "No file provided. Please provide a path to the source file."
    exit 0
fi

if [ ! -f $1 ];
    then
        echo "Invalid path to file."
        exit 0
fi

echo $1
cp $1 lineminer-sinatra/assets/datafile

cd lineminer-sinatra
export RACK_ENV='production'
ruby app.rb -s Puma