/// Details about an unknown output for a node.
pub const UnknownNodeOutputFlowValidationDetails = struct {
    /// The name of the node with the unknown output.
    node: []const u8,

    /// The name of the unknown output.
    output: []const u8,

    pub const json_field_names = .{
        .node = "node",
        .output = "output",
    };
};
