/// Details about a cyclic connection detected in the flow.
pub const CyclicConnectionFlowValidationDetails = struct {
    /// The name of the connection that causes the cycle in the flow.
    connection: []const u8,

    pub const json_field_names = .{
        .connection = "connection",
    };
};
