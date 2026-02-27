const FlowCondition = @import("flow_condition.zig").FlowCondition;

/// Defines a condition node in your flow. You can specify conditions that
/// determine which node comes next in the flow. For more information, see [Node
/// types in a
/// flow](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-nodes.html)
/// in the Amazon Bedrock User Guide.
pub const ConditionFlowNodeConfiguration = struct {
    /// An array of conditions. Each member contains the name of a condition and an
    /// expression that defines the condition.
    conditions: []const FlowCondition,

    pub const json_field_names = .{
        .conditions = "conditions",
    };
};
