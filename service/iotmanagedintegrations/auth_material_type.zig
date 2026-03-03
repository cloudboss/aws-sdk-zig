const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom_protocol_qr_bar_code => "CUSTOM_PROTOCOL_QR_BAR_CODE",
            .wifi_setup_qr_bar_code => "WIFI_SETUP_QR_BAR_CODE",
            .zwave_qr_bar_code => "ZWAVE_QR_BAR_CODE",
            .zigbee_qr_bar_code => "ZIGBEE_QR_BAR_CODE",
            .discovered_device => "DISCOVERED_DEVICE",
            .pre_onboarded_cloud => "PRE_ONBOARDED_CLOUD",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
