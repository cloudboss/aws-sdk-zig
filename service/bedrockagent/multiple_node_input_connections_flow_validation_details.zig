/// Details about multiple connections to a single node input.
pub const MultipleNodeInputConnectionsFlowValidationDetails = struct {
    /// The name of the input with multiple connections to it.
    input: []const u8,

    /// The name of the node containing the input with multiple connections.
    node: []const u8,

    pub const json_field_names = .{
        .input = "input",
        .node = "node",
    };
};
