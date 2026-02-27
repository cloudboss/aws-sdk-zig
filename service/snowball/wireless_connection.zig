/// Configures the wireless connection on an Snowball Edge device.
pub const WirelessConnection = struct {
    /// Enables the Wi-Fi adapter on an Snowball Edge device.
    is_wifi_enabled: bool = false,

    pub const json_field_names = .{
        .is_wifi_enabled = "IsWifiEnabled",
    };
};
