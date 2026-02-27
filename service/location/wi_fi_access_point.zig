/// Wi-Fi access point.
pub const WiFiAccessPoint = struct {
    /// Medium access control address (Mac).
    mac_address: []const u8,

    /// Received signal strength (dBm) of the WLAN measurement data.
    rss: i32,

    pub const json_field_names = .{
        .mac_address = "MacAddress",
        .rss = "Rss",
    };
};
