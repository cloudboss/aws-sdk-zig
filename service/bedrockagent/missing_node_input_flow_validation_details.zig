/// Details about a missing required input in a node.
pub const MissingNodeInputFlowValidationDetails = struct {
    /// The name of the missing input.
    input: []const u8,

    /// The name of the node missing the required input.
    node: []const u8,

    pub const json_field_names = .{
        .input = "input",
        .node = "node",
    };
};
