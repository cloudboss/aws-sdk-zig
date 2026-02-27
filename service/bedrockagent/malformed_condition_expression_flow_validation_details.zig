/// Details about a malformed condition expression in a node.
pub const MalformedConditionExpressionFlowValidationDetails = struct {
    /// The error message describing why the condition expression is malformed.
    cause: []const u8,

    /// The name of the malformed condition.
    condition: []const u8,

    /// The name of the node containing the malformed condition expression.
    node: []const u8,

    pub const json_field_names = .{
        .cause = "cause",
        .condition = "condition",
        .node = "node",
    };
};
