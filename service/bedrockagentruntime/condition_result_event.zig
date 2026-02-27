const SatisfiedCondition = @import("satisfied_condition.zig").SatisfiedCondition;

/// Contains information about a condition evaluation result during a flow
/// execution. This event is generated when a condition node in the flow
/// evaluates its conditions.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const ConditionResultEvent = struct {
    /// The name of the condition node that evaluated the conditions.
    node_name: []const u8,

    /// A list of conditions that were satisfied during the evaluation.
    satisfied_conditions: []const SatisfiedCondition,

    /// The timestamp when the condition evaluation occurred.
    timestamp: i64,

    pub const json_field_names = .{
        .node_name = "nodeName",
        .satisfied_conditions = "satisfiedConditions",
        .timestamp = "timestamp",
    };
};
