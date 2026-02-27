/// Details about an unknown condition for a connection.
pub const UnknownConnectionConditionFlowValidationDetails = struct {
    /// The name of the connection with the unknown condition.
    connection: []const u8,

    pub const json_field_names = .{
        .connection = "connection",
    };
};
