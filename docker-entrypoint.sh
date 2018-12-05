#!/bin/bash
set -e

# Add prometheus as command if needed
if [[ "$1" == -* ]]; then
	set -- prometheus "$@"
fi

exec "$@"
