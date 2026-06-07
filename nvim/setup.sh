#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"

echo "Setting up neovim configuration..."
echo "  Source: $SCRIPT_DIR"
echo "  Target: $NVIM_CONFIG"

# Install neovim if not present
if ! command -v nvim &> /dev/null; then
    echo ""
    if command -v brew &> /dev/null; then
        echo "Installing neovim via Homebrew..."
        brew install neovim
    else
        echo "neovim is not installed and Homebrew is not available."
        echo "Please install neovim manually: https://github.com/neovim/neovim/releases"
        exit 1
    fi
else
    echo "  neovim: $(nvim --version | head -1)"
fi

# Create ~/.config/nvim if needed
mkdir -p "$NVIM_CONFIG"

# Remove existing symlinks or files at target locations
for item in init.lua lua lazy-lock.json; do
    target="$NVIM_CONFIG/$item"
    if [ -L "$target" ] || [ -e "$target" ]; then
        echo "  Removing existing: $target"
        rm -rf "$target"
    fi
done

# Create symlinks
ln -s "$SCRIPT_DIR/init.lua" "$NVIM_CONFIG/init.lua"
ln -s "$SCRIPT_DIR/lua" "$NVIM_CONFIG/lua"
ln -s "$SCRIPT_DIR/lazy-lock.json" "$NVIM_CONFIG/lazy-lock.json"

echo ""
echo "Symlinks created:"
echo "  $NVIM_CONFIG/init.lua -> $SCRIPT_DIR/init.lua"
echo "  $NVIM_CONFIG/lua -> $SCRIPT_DIR/lua/"
echo "  $NVIM_CONFIG/lazy-lock.json -> $SCRIPT_DIR/lazy-lock.json"
echo ""
echo "Syncing plugins to the locked, known-good state..."
if nvim --headless "+Lazy! sync" +qa; then
    echo "  plugins synced."
else
    echo "  WARNING: plugin sync reported an error; launch nvim and run :Lazy to inspect."
fi

echo ""
echo "Verifying the config loads without errors..."
if nvim --headless "+lua vim.cmd('messages')" +qa 2>&1 | grep -qiE 'error|failed to load'; then
    echo "  WARNING: errors detected on startup; launch nvim to investigate."
else
    echo "  config loaded cleanly."
fi

echo ""
echo "Done."
