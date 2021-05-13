To use touch-id for CLI sudo:

# Open the sudo utility
sudo vi /etc/pam.d/sudo

# Add the following as the first line
auth sufficient pam_tid.so


# to make home and end keys work like other platforms
cp -r Library/KeyBindings ~/Library/KeyBindings

