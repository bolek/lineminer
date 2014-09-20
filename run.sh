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

realpath_osx() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

ABSOLUTE_PATH=$(realpath_osx "$1")

echo 'Generating config'
cp lineminer-sinatra/config_tpl.yml lineminer-sinatra/config.yml
sed -i '' "s?#{datafile_production}?${ABSOLUTE_PATH}?g" lineminer-sinatra/config.yml

cd lineminer-sinatra

echo 'Setting environment variables'
export RACK_ENV='production'

echo 'Initiating server'
ruby app.rb -s Puma