/// The configuration of a connection between a condition node and another node.
pub const FlowConditionalConnectionConfiguration = struct {
    /// The condition that triggers this connection. For more information about how
    /// to write conditions, see the **Condition** node type in the [Node
    /// types](https://docs.aws.amazon.com/bedrock/latest/userguide/node-types.html)
    /// topic in the Amazon Bedrock User Guide.
    condition: []const u8,

    pub const json_field_names = .{
        .condition = "condition",
    };
};
