
# Lucity Linux Web Terminal

Ubuntu 24.04 browser-based Linux terminal.

## Features

- Ubuntu 24.04
- PHP CLI
- Composer
- Python 3
- Python venv and pip
- Node.js and npm
- Git
- Bash
- Nano and Vim
- Browser terminal using ttyd
- Basic authentication
- Non-root execution
- Ephemeral workspace

## Environment Variables

- TERMINAL_USER
- TERMINAL_PASSWORD
- PORT

## Local Deployment

1. Clone the repository.
2. Copy .env.example to .env.
3. Set a strong password.
4. Run:

docker compose up -d --build

5. Open:

http://localhost:7681

## Security

Never expose the terminal publicly without authentication.

## Storage

Workspace is cleared every time the container starts.
No persistent workspace volume is used.
