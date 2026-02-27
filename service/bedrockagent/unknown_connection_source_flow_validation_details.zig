/// Details about an unknown source node for a connection.
pub const UnknownConnectionSourceFlowValidationDetails = struct {
    /// The name of the connection with the unknown source.
    connection: []const u8,

    pub const json_field_names = .{
        .connection = "connection",
    };
};
