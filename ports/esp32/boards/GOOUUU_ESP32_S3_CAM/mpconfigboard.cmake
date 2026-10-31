include(boards/mpconfigboard_esp32s3_common.cmake)

list(REMOVE_ITEM SDKCONFIG_DEFAULTS boards/sdkconfig.spiram_quad)

list(APPEND SDKCONFIG_DEFAULTS
    boards/sdkconfig.flash_qio_80m
    boards/GOOUUU_ESP32_S3_CAM/sdkconfig.board
)
