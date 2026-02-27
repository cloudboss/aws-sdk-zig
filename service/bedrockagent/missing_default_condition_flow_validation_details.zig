/// Details about a missing default condition in a conditional node.
pub const MissingDefaultConditionFlowValidationDetails = struct {
    /// The name of the node missing the default condition.
    node: []const u8,

    pub const json_field_names = .{
        .node = "node",
    };
};
