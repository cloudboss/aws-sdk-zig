/// Details about an unknown input for a node.
pub const UnknownNodeInputFlowValidationDetails = struct {
    /// The name of the node with the unknown input.
    input: []const u8,

    /// The name of the unknown input.
    node: []const u8,

    pub const json_field_names = .{
        .input = "input",
        .node = "node",
    };
};
