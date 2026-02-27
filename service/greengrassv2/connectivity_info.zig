/// Contains information about an endpoint and port where client devices can
/// connect to an
/// MQTT broker on a Greengrass core device.
pub const ConnectivityInfo = struct {
    /// The IP address or DNS address where client devices can connect to an MQTT
    /// broker on the
    /// Greengrass core device.
    host_address: ?[]const u8,

    /// An ID for the connectivity information.
    id: ?[]const u8,

    /// Additional metadata to provide to client devices that connect to this core
    /// device.
    metadata: ?[]const u8,

    /// The port where the MQTT broker operates on the core device. This port is
    /// typically 8883,
    /// which is the default port for the MQTT broker component that runs on core
    /// devices.
    port_number: i32 = 0,

    pub const json_field_names = .{
        .host_address = "hostAddress",
        .id = "id",
        .metadata = "metadata",
        .port_number = "portNumber",
    };
};
