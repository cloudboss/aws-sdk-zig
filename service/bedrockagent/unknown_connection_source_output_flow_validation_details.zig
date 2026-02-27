/// Details about an unknown source output for a connection.
pub const UnknownConnectionSourceOutputFlowValidationDetails = struct {
    /// The name of the connection with the unknown source output.
    connection: []const u8,

    pub const json_field_names = .{
        .connection = "connection",
    };
};
