#!/bin/bash

# Constants
SCRIPT_URL="https://raw.githubusercontent.com/KernelKrise/httpy/refs/heads/main/httpy"
INSTALL_DIR="$HOME/.local/bin"
INSTALL_PATH="$INSTALL_DIR/httpy"

# Logging
ilog() {
    echo "[*] ${1}"
}

# Error handling
die() {
    echo "[!] ${1}" >&2
    exit 1
}

# Check downloader
if command -v curl >/dev/null 2>&1; then
    DL_CMD="curl -fsSL"
elif command -v wget >/dev/null 2>&1; then
    DL_CMD="wget -qO-"
else
    die "Neither curl nor wget found"
fi

# Ensure install dir exists
if [ ! -d "$INSTALL_DIR" ]; then
    ilog "Creating $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR" || die "Failed to create $INSTALL_DIR"
fi

# Download
ilog "Downloading script"
$DL_CMD "$SCRIPT_URL" > "$INSTALL_PATH" || die "Download failed"

# Make executable
ilog "Making script executable"
chmod +x "$INSTALL_PATH" || die "chmod failed"

# Check PATH
case ":$PATH:" in
    *":$INSTALL_DIR:"*)
        ilog "$INSTALL_DIR is in PATH"
        ;;
    *)
        echo "[!] $INSTALL_DIR is not in PATH"
        echo "    Add this line to your shell config:"
        echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
        ;;
esac

ilog "Installed to $INSTALL_PATH"