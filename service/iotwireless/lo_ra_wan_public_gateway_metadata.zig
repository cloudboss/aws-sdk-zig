/// LoRaWAN public gateway metadata.
pub const LoRaWANPublicGatewayMetadata = struct {
    /// Boolean that indicates whether downlink is allowed using the network.
    dl_allowed: ?bool = null,

    /// The ID of the gateways that are operated by the network provider.
    id: ?[]const u8 = null,

    /// The ID of the LoRaWAN public network provider.
    provider_net_id: ?[]const u8 = null,

    rf_region: ?[]const u8 = null,

    /// The RSSI (received signal strength indicator) value.
    rssi: ?f64 = null,

    /// The SNR (signal to noise ratio) value.
    snr: ?f64 = null,

    pub const json_field_names = .{
        .dl_allowed = "DlAllowed",
        .id = "Id",
        .provider_net_id = "ProviderNetId",
        .rf_region = "RfRegion",
        .rssi = "Rssi",
        .snr = "Snr",
    };
};
