#!/bin/bash
# keyd/setup.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KEYD_CONF="/etc/keyd/default.conf"

# 引数チェック
if [ $# -ne 1 ]; then
    echo "Usage: $0 <config-file>"
    echo "Example: $0 thinkpad13.conf"
    echo ""
    echo "Available config files:"
    ls -1 "$SCRIPT_DIR"/*.conf 2>/dev/null || echo "  (none found)"
    exit 1
fi

CONFIG_FILE="$1"
SOURCE_CONF="$SCRIPT_DIR/$CONFIG_FILE"

# 指定されたconfファイルが存在するか確認
if [ ! -f "$SOURCE_CONF" ]; then
    echo "Error: Config file not found: $SOURCE_CONF"
    exit 1
fi

echo "Setting up keyd..."

# keydがインストールされているか確認
if ! command -v keyd &> /dev/null; then
    echo "Error: keyd is not installed."
    echo "Please install keyd first:"
    echo "  Arch: sudo pacman -S keyd"
    echo "  Ubuntu/Debian: (build from source or use AUR)"
    exit 1
fi

# /etc/keyd/ ディレクトリが存在するか確認
if [ ! -d "/etc/keyd" ]; then
    echo "Creating /etc/keyd directory..."
    sudo mkdir -p /etc/keyd
fi

# シンボリックリンクを作成
echo "Creating symlink: $KEYD_CONF -> $SOURCE_CONF"
sudo ln -sf "$SOURCE_CONF" "$KEYD_CONF"

# keyd サービスを有効化・起動
echo "Enabling and starting keyd service..."
sudo systemctl enable keyd
sudo systemctl restart keyd

echo "Done! keyd is now configured with $CONFIG_FILE and running."
echo "You can reload the config anytime with: sudo keyd reload"
