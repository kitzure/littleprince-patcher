#!/bin/bash
# Prince 3-in-1 Server (port 80)
# Keep this running while playing. Press Ctrl+C to stop.

cd "$(dirname "$0")"

echo ""
echo "  Starting the local server on port 80..."
echo "  Keep this terminal open while playing."
echo "  Press Ctrl+C to stop."
echo ""

if [ "$(id -u)" -ne 0 ]; then
    echo "  Requesting root (needed for port 80)..."
    exec sudo "$0" "$@"
fi

python3 fake_server.py
