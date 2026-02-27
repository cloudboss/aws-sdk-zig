/// LoRaWAN public gateway metadata.
pub const LoRaWANPublicGatewayMetadata = struct {
    /// Boolean that indicates whether downlink is allowed using the network.
    dl_allowed: ?bool,

    /// The ID of the gateways that are operated by the network provider.
    id: ?[]const u8,

    /// The ID of the LoRaWAN public network provider.
    provider_net_id: ?[]const u8,

    rf_region: ?[]const u8,

    /// The RSSI (received signal strength indicator) value.
    rssi: ?f64,

    /// The SNR (signal to noise ratio) value.
    snr: ?f64,

    pub const json_field_names = .{
        .dl_allowed = "DlAllowed",
        .id = "Id",
        .provider_net_id = "ProviderNetId",
        .rf_region = "RfRegion",
        .rssi = "Rssi",
        .snr = "Snr",
    };
};
