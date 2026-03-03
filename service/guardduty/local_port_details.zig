/// Contains information about the port for the local connection.
pub const LocalPortDetails = struct {
    /// The port number of the local connection.
    port: ?i32 = null,

    /// The port name of the local connection.
    port_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .port = "Port",
        .port_name = "PortName",
    };
};
