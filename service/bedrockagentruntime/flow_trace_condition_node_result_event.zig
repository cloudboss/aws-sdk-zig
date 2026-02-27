const FlowTraceCondition = @import("flow_trace_condition.zig").FlowTraceCondition;

/// Contains information about an output from a condition node. For more
/// information, see [Track each step in your prompt flow by viewing its trace
/// in Amazon
/// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-trace.html).
pub const FlowTraceConditionNodeResultEvent = struct {
    /// The name of the condition node.
    node_name: []const u8,

    /// An array of objects containing information about the conditions that were
    /// satisfied.
    satisfied_conditions: []const FlowTraceCondition,

    /// The date and time that the trace was returned.
    timestamp: i64,

    pub const json_field_names = .{
        .node_name = "nodeName",
        .satisfied_conditions = "satisfiedConditions",
        .timestamp = "timestamp",
    };
};
