/// Details about a missing required output in a node.
pub const MissingNodeOutputFlowValidationDetails = struct {
    /// The name of the node missing the required output.
    node: []const u8,

    /// The name of the missing output.
    output: []const u8,

    pub const json_field_names = .{
        .node = "node",
        .output = "output",
    };
};
