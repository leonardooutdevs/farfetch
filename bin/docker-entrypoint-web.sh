#!/usr/bin/env bash

set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /farfetch/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec bundle exec rails server -p 3000 -b 0.0.0.0

# Always keep this here as it ensures your latest built assets make their way
# into your volume persisted public directory.
# cp -r /public /farfetch

exec "$@"
