/// Defines a condition in the condition node.
pub const FlowCondition = struct {
    /// Defines the condition. You must refer to at least one of the inputs in the
    /// condition. For more information, expand the Condition node section in [Node
    /// types in prompt
    /// flows](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-how-it-works.html#flows-nodes).
    expression: ?[]const u8,

    /// A name for the condition that you can reference.
    name: []const u8,

    pub const json_field_names = .{
        .expression = "expression",
        .name = "name",
    };
};
