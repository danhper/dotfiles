#!/bin/bash

PATH=/usr/bin

set -euo pipefail

app_name="${1:-}"
mode_override=""
target_override="${BASE_DIR:-}"

case "${2:-}" in
    installed|appimage)
        mode_override="$2"
        target_override="${3:-${BASE_DIR:-}}"
        ;;
    "")
        ;;
    *)
        target_override="$2"
        ;;
esac

if [ -z "$app_name" ]; then
    echo "Usage: $0 <app_name> [installed|appimage] [base_dir_or_appimage]"
    echo "       BASE_DIR=/path $0 <app_name>"
    exit 1
fi

case $app_name in
    "1password")
        MODE="installed"
        BASE_DIR="/opt/1Password"
        ICONS=("$HOME/Dropbox/misc/app-icons/1password/tray_unlocked.png")
        TARGET_DIR=app_src/images
        ;;
    "clickup")
        BASE_DIR="/opt/clickup"
        if [ -n "$mode_override" ]; then
            MODE="$mode_override"
        elif [ -f "$BASE_DIR/resources/app.asar" ]; then
            MODE="installed"
        else
            MODE="appimage"
        fi
        APPIMAGE="/home/daniel/Applications/clickup-3.5.230x86_64_d6aecde6aa4ce5e832de92852adbb6d0.AppImage"
        ICONS=("$HOME"/Dropbox/misc/app-icons/clickup/tray-icon-production-Template*)
        TARGET_DIR=app_src
        ;;
    *)
        echo "Invalid app name: $app_name"
        exit 1
        ;;
esac

case "$app_name:$MODE" in
    1password:installed|clickup:installed|clickup:appimage)
        ;;
    *)
        echo "Invalid mode for $app_name: $MODE" >&2
        exit 1
        ;;
esac

if [ -n "$target_override" ]; then
    if [ "$MODE" = "appimage" ]; then
        APPIMAGE="$target_override"
    else
        BASE_DIR="$target_override"
    fi
fi

CURRENT_DIR=$(pwd)

TEMP_DIR=$(mktemp -d)
trap 'cd "$CURRENT_DIR"; rm -rf "$TEMP_DIR"' EXIT

cd "$TEMP_DIR"

run_asar() {
    if command -v asar >/dev/null; then
        asar "$@"
        return
    fi

    if ! command -v npm >/dev/null; then
        echo "asar or npm is required to patch app.asar" >&2
        exit 1
    fi

    npm exec --yes --package @electron/asar -- asar "$@"
}

build_unpack_args() {
    local unpacked_dir="$1"
    PACK_ARGS=()

    if [ ! -d "$unpacked_dir" ]; then
        return
    fi

    if [ -d "$unpacked_dir/node_modules" ]; then
        local package_dir scoped_package_dir package_name scoped_package_name

        while IFS= read -r -d '' package_dir; do
            package_name="${package_dir##*/}"

            if [[ "$package_name" == @* ]]; then
                while IFS= read -r -d '' scoped_package_dir; do
                    scoped_package_name="${scoped_package_dir##*/}"
                    PACK_ARGS+=(--unpack-dir "node_modules/$package_name/$scoped_package_name")
                done < <(find "$package_dir" -mindepth 1 -maxdepth 1 -type d -print0)
            else
                PACK_ARGS+=(--unpack-dir "node_modules/$package_name")
            fi
        done < <(find "$unpacked_dir/node_modules" -mindepth 1 -maxdepth 1 -type d -print0)
    fi
}

patch_asar() {
    local source_asar="$1"
    local output_asar="$2"
    local source_unpacked="${source_asar}.unpacked"

    rm -rf app_src app.asar app.asar.unpacked
    cp "$source_asar" app.asar
    if [ -d "$source_unpacked" ]; then
        cp -a "$source_unpacked" app.asar.unpacked
    fi

    run_asar extract app.asar app_src
    rm app.asar

    for icon in "${ICONS[@]}"; do
        if [ ! -e "$icon" ]; then
            echo "Icon not found: $icon" >&2
            exit 1
        fi

        cp "$icon" "$TARGET_DIR"
    done

    build_unpack_args app.asar.unpacked
    rm -rf "$output_asar" "${output_asar}.unpacked"
    run_asar pack "${PACK_ARGS[@]}" app_src "$output_asar"
}

patch_installed_app() {
    patch_asar "$BASE_DIR/resources/app.asar" app.asar
    sudo cp app.asar "$BASE_DIR/resources/app.asar"

    if [ -d app.asar.unpacked ]; then
        sudo rm -rf "$BASE_DIR/resources/app.asar.unpacked"
        sudo cp -a app.asar.unpacked "$BASE_DIR/resources/app.asar.unpacked"
    fi
}

patch_appimage() {
    if [ ! -x "$APPIMAGE" ]; then
        echo "AppImage not found or not executable: $APPIMAGE" >&2
        exit 1
    fi

    command -v mksquashfs >/dev/null || {
        echo "mksquashfs is required to rebuild the ClickUp AppImage" >&2
        exit 1
    }

    "$APPIMAGE" --appimage-extract >/dev/null

    if [ ! -f squashfs-root/resources/app.asar ]; then
        echo "Could not find resources/app.asar in extracted AppImage" >&2
        exit 1
    fi

    patch_asar squashfs-root/resources/app.asar squashfs-root/resources/app.asar

    local offset
    offset=$("$APPIMAGE" --appimage-offset)
    if ! [[ "$offset" =~ ^[0-9]+$ ]]; then
        echo "Could not determine AppImage runtime offset" >&2
        exit 1
    fi

    local backup
    backup="${APPIMAGE}.bak.$(date +%Y%m%d%H%M%S)"
    cp -p "$APPIMAGE" "$backup"

    head -c "$offset" "$backup" > runtime
    mksquashfs squashfs-root app.squashfs -root-owned -noappend >/dev/null
    cat runtime app.squashfs > patched.AppImage
    chmod --reference="$backup" patched.AppImage
    mv patched.AppImage "$APPIMAGE"

    echo "Updated $APPIMAGE"
    echo "Backup saved to $backup"
}

case "$MODE" in
    installed)
        patch_installed_app
        ;;
    appimage)
        patch_appimage
        ;;
esac
