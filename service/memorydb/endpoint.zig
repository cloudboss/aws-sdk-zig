/// Represents the information required for client programs to connect to the
/// cluster and its nodes.
pub const Endpoint = struct {
    /// The DNS hostname of the node.
    address: ?[]const u8 = null,

    /// The port number that the engine is listening on.
    port: i32 = 0,

    pub const json_field_names = .{
        .address = "Address",
        .port = "Port",
    };
};
