const LoRaWANGatewayMetadata = @import("lo_ra_wan_gateway_metadata.zig").LoRaWANGatewayMetadata;
const LoRaWANPublicGatewayMetadata = @import("lo_ra_wan_public_gateway_metadata.zig").LoRaWANPublicGatewayMetadata;

/// LoRaWAN device metatdata.
pub const LoRaWANDeviceMetadata = struct {
    /// The DataRate value.
    data_rate: ?i32 = null,

    /// The DevEUI value.
    dev_eui: ?[]const u8 = null,

    /// The FPort value.
    f_port: ?i32 = null,

    /// The device's channel frequency in Hz.
    frequency: ?i32 = null,

    /// Information about the gateways accessed by the device.
    gateways: ?[]const LoRaWANGatewayMetadata = null,

    /// Information about the LoRaWAN public network accessed by the device.
    public_gateways: ?[]const LoRaWANPublicGatewayMetadata = null,

    /// The date and time of the metadata.
    timestamp: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_rate = "DataRate",
        .dev_eui = "DevEui",
        .f_port = "FPort",
        .frequency = "Frequency",
        .gateways = "Gateways",
        .public_gateways = "PublicGateways",
        .timestamp = "Timestamp",
    };
};
