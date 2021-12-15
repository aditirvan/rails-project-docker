#!/bin/sh
# Ruby DB Migrate Script
cd /usr/src/app
bundle exec rake db:migrate
nginx -g 'daemon off;'