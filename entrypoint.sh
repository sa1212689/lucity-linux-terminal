
#!/usr/bin/env bash

set -e

# Require authentication credentials
: "${TERMINAL_USER:?TERMINAL_USER is required}"
: "${TERMINAL_PASSWORD:?TERMINAL_PASSWORD is required}"

if [[ "$TERMINAL_PASSWORD" == *:* ]]; then
    echo "Password must not contain a colon."
    exit 1
fi

# Reset workspace on every container start
mkdir -p /workspace
find /workspace -mindepth 1 -maxdepth 1 \
    -exec rm -rf -- {} +

echo "=================================="
echo " Ubuntu Web Terminal"
echo " PHP: $(php -v | head -n 1)"
echo " Python: $(python3 --version)"
echo " Composer: $(composer --version --no-ansi)"
echo "=================================="

# Start browser terminal
exec ttyd \
    --writable \
    --interface 0.0.0.0 \
    --port "${PORT:-7681}" \
    --credential "${TERMINAL_USER}:${TERMINAL_PASSWORD}" \
    bash -l
