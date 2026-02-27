/// LoRaWAN gateway metatdata.
pub const LoRaWANGatewayMetadata = struct {
    /// The gateway's EUI value.
    gateway_eui: ?[]const u8,

    /// The RSSI value.
    rssi: ?f64,

    /// The SNR value.
    snr: ?f64,

    pub const json_field_names = .{
        .gateway_eui = "GatewayEui",
        .rssi = "Rssi",
        .snr = "Snr",
    };
};
