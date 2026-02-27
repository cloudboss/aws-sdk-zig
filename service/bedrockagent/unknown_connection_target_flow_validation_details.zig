/// Details about an unknown target node for a connection.
pub const UnknownConnectionTargetFlowValidationDetails = struct {
    /// The name of the connection with the unknown target.
    connection: []const u8,

    pub const json_field_names = .{
        .connection = "connection",
    };
};
