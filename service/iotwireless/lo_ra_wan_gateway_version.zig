/// LoRaWANGatewayVersion object.
pub const LoRaWANGatewayVersion = struct {
    /// The model number of the wireless gateway.
    model: ?[]const u8 = null,

    /// The version of the wireless gateway firmware.
    package_version: ?[]const u8 = null,

    /// The basic station version of the wireless gateway.
    station: ?[]const u8 = null,

    pub const json_field_names = .{
        .model = "Model",
        .package_version = "PackageVersion",
        .station = "Station",
    };
};
