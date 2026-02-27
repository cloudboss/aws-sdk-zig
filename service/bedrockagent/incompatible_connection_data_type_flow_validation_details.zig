/// Details about incompatible data types in a connection between nodes.
pub const IncompatibleConnectionDataTypeFlowValidationDetails = struct {
    /// The name of the connection with incompatible data types.
    connection: []const u8,

    pub const json_field_names = .{
        .connection = "connection",
    };
};
