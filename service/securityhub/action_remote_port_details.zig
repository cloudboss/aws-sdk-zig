/// Provides information about the remote port that was involved in an attempted
/// network
/// connection.
pub const ActionRemotePortDetails = struct {
    /// The number of the port.
    port: ?i32 = null,

    /// The port name of the remote connection.
    ///
    /// Length Constraints: 128.
    port_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .port = "Port",
        .port_name = "PortName",
    };
};
