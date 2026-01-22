#!/bin/bash
#
# pull-updates.sh
# Pulls latest changes from UABclass remote
#

cd "$(dirname "$0")"

echo "Pulling latest UABclass updates..."
git pull --rebase

echo "Done!"
