/// Details about an unknown target input for a connection.
pub const UnknownConnectionTargetInputFlowValidationDetails = struct {
    /// The name of the connection with the unknown target input.
    connection: []const u8,

    pub const json_field_names = .{
        .connection = "connection",
    };
};
