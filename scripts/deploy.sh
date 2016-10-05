#!/usr/bin/env bash

set -e

env="$1"

case $env in
    test)
        port=4444
        ;;
    prod|production)
        port=3333
        ;;
    *)
        echo "Must specify environment (ie: test, prod, or production)"
        exit 1
        ;;
esac

if [ -e "$PWD/tmp/pids/server.pid" ]; then
	echo '******Killing server'
	less $PWD/tmp/pids/server.pid | xargs kill
	echo ''
fi

echo '******Pulling latest master'
git pull
echo ''

echo '******Rake migrating DB'
bundle exec rake db:migrate
echo ''

echo '******Running Server as daemon'
rails s -p $port -d
echo ''

echo '******DONE'
