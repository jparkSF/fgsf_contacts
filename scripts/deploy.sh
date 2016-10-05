#!/usr/bin/env bash

set -e

env="$1"

case $env in
    test)
    port=4444
    ;;
    prod|producion)
    port=3333
    ;;
    *)
    # unknown option
    echo "must specify environemtn (ie: test or prod)"
    exit 1
    ;;
esac

if [ -e "$PWD/tmp/pids/server.pid" ]; then
	echo 'Killing server..'
	less $PWD/tmp/pids/server.pid | xargs kill
fi

echo 'Pull latest master'
git pull
echo 'Db migrate'
bundle exec rake db:migrate
echo 'Running Server as daemon'
rails s -p $port -d
