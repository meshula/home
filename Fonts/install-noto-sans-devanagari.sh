#!/bin/bash
set -e

FONT_NAME="NotoSans-Regular.otf"
FONT_FAMILY="Noto Sans"
FONT_URL="https://raw.githubusercontent.com/googlefonts/noto-fonts/main/unhinted/otf/NotoSans/${FONT_NAME}"

FONT_DIR="$HOME/Library/Fonts"
KITTY_CONF="$HOME/.config/kitty/kitty.conf"
TEMP_DIR="$(mktemp -d)"

echo "Starting Noto Sans setup..."

# Download font
echo "Downloading font..."
curl -L --fail "$FONT_URL" -o "$TEMP_DIR/$FONT_NAME"

# Basic sanity check: TrueType or OpenType
if ! xxd -l 4 "$TEMP_DIR/$FONT_NAME" | grep -qE '00000000: (0001 0000|4f54 544f)'; then
  echo "Downloaded file does not look like a font. Aborting."
  exit 1
fi

# Install font
mkdir -p "$FONT_DIR"
if [ ! -f "$FONT_DIR/$FONT_NAME" ]; then
  cp "$TEMP_DIR/$FONT_NAME" "$FONT_DIR/"
  echo "Installed $FONT_NAME to $FONT_DIR"
else
  echo "Font already installed, skipping copy."
fi

# Update kitty.conf
mkdir -p "$(dirname "$KITTY_CONF")"
touch "$KITTY_CONF"

FONT_BLOCK=$(cat <<'EOF'
# BEGIN_KITTY_FONTS
font_family      family="Noto Sans"
font_family      family="Menlo"
bold_font        auto
italic_font      auto
bold_italic_font auto
# END_KITTY_FONTS
EOF
)

if grep -q "# BEGIN_KITTY_FONTS" "$KITTY_CONF"; then
  perl -0777 -i -pe \
    "s|# BEGIN_KITTY_FONTS.*?# END_KITTY_FONTS|$FONT_BLOCK|s" \
    "$KITTY_CONF"
  echo "Updated existing kitty font configuration."
else
  printf "\n%s\n" "$FONT_BLOCK" >> "$KITTY_CONF"
  echo "Added kitty font configuration."
fi

rm -rf "$TEMP_DIR"

echo "Done. Restart kitty to apply changes."
