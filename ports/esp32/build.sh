#!/usr/bin/env bash
set -euo pipefail

PORT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MICROPY_DIR="$(cd -- "$PORT_DIR/../.." && pwd)"
PROJECT_ROOT="$(cd -- "$MICROPY_DIR/.." && pwd)"

IDF_EXPORT_SH="${IDF_EXPORT_SH:-$HOME/.espressif/v5.5.5/esp-idf/export.sh}"
if [[ ! -f "$IDF_EXPORT_SH" ]]; then
    echo "ESP-IDF export.sh not found: $IDF_EXPORT_SH" >&2
    exit 1
fi

source "$IDF_EXPORT_SH"

BOARD="GOOUUU_ESP32_S3_CAM"
BOARD_VARIANT="SPIRAM_OCT"
BUILD="build-${BOARD}-${BOARD_VARIANT}"

make -C "$PORT_DIR" \
    -j"${JOBS:-$(nproc)}" \
    BOARD="$BOARD" \
    BOARD_VARIANT="$BOARD_VARIANT" \
    BUILD="$BUILD" \
    USER_C_MODULES="$PROJECT_ROOT/user_modules"

FIRMWARE="$PORT_DIR/$BUILD/firmware.bin"
if [[ ! -s "$FIRMWARE" ]]; then
    echo "Build finished without a firmware image: $FIRMWARE" >&2
    exit 1
fi

cp "$FIRMWARE" "$PROJECT_ROOT/firmware.bin"
echo "Firmware created: $PROJECT_ROOT/firmware.bin"
