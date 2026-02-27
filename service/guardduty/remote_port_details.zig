/// Contains information about the remote port.
pub const RemotePortDetails = struct {
    /// The port number of the remote connection.
    port: ?i32,

    /// The port name of the remote connection.
    port_name: ?[]const u8,

    pub const json_field_names = .{
        .port = "Port",
        .port_name = "PortName",
    };
};
