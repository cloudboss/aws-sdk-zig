/// Information about a Greengrass core's connectivity.
pub const ConnectivityInfo = struct {
    /// The endpoint for the Greengrass core. Can be an IP address or DNS.
    host_address: ?[]const u8 = null,

    /// The ID of the connectivity information.
    id: ?[]const u8 = null,

    /// Metadata for this endpoint.
    metadata: ?[]const u8 = null,

    /// The port of the Greengrass core. Usually 8883.
    port_number: ?i32 = null,

    pub const json_field_names = .{
        .host_address = "HostAddress",
        .id = "Id",
        .metadata = "Metadata",
        .port_number = "PortNumber",
    };
};
