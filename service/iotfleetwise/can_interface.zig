/// A single controller area network (CAN) device interface.
pub const CanInterface = struct {
    /// The unique name of the interface.
    name: []const u8,

    /// The name of the communication protocol for the interface.
    protocol_name: ?[]const u8,

    /// The version of the communication protocol for the interface.
    protocol_version: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .protocol_name = "protocolName",
        .protocol_version = "protocolVersion",
    };
};
