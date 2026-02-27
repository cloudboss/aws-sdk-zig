pub const AuthMaterialType = enum {
    custom_protocol_qr_bar_code,
    wifi_setup_qr_bar_code,
    zwave_qr_bar_code,
    zigbee_qr_bar_code,
    discovered_device,
    pre_onboarded_cloud,

    pub const json_field_names = .{
        .custom_protocol_qr_bar_code = "CUSTOM_PROTOCOL_QR_BAR_CODE",
        .wifi_setup_qr_bar_code = "WIFI_SETUP_QR_BAR_CODE",
        .zwave_qr_bar_code = "ZWAVE_QR_BAR_CODE",
        .zigbee_qr_bar_code = "ZIGBEE_QR_BAR_CODE",
        .discovered_device = "DISCOVERED_DEVICE",
        .pre_onboarded_cloud = "PRE_ONBOARDED_CLOUD",
    };
};
