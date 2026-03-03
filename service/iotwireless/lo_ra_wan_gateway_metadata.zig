/// LoRaWAN gateway metatdata.
pub const LoRaWANGatewayMetadata = struct {
    /// The gateway's EUI value.
    gateway_eui: ?[]const u8 = null,

    /// The RSSI value.
    rssi: ?f64 = null,

    /// The SNR value.
    snr: ?f64 = null,

    pub const json_field_names = .{
        .gateway_eui = "GatewayEui",
        .rssi = "Rssi",
        .snr = "Snr",
    };
};
