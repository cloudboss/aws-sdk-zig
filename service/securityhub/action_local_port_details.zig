/// For `NetworkConnectionAction` and `PortProbeDetails`,
/// `LocalPortDetails` provides information about the local port that was
/// involved in the action.
pub const ActionLocalPortDetails = struct {
    /// The number of the port.
    port: ?i32,

    /// The port name of the local connection.
    ///
    /// Length Constraints: 128.
    port_name: ?[]const u8,

    pub const json_field_names = .{
        .port = "Port",
        .port_name = "PortName",
    };
};
