/// Details about duplicate condition expressions found in a condition node.
pub const DuplicateConditionExpressionFlowValidationDetails = struct {
    /// The duplicated condition expression.
    expression: []const u8,

    /// The name of the node containing the duplicate condition expressions.
    node: []const u8,

    pub const json_field_names = .{
        .expression = "expression",
        .node = "node",
    };
};
