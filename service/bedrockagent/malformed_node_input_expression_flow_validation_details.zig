/// Details about a malformed input expression in a node.
pub const MalformedNodeInputExpressionFlowValidationDetails = struct {
    /// The error message describing why the input expression is malformed.
    cause: []const u8,

    /// The name of the input with the malformed expression.
    input: []const u8,

    /// The name of the node containing the malformed input expression.
    node: []const u8,

    pub const json_field_names = .{
        .cause = "cause",
        .input = "input",
        .node = "node",
    };
};
