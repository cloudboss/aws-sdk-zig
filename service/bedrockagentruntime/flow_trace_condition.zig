/// Contains information about a condition that was satisfied. For more
/// information, see [Track each step in your prompt flow by viewing its trace
/// in Amazon
/// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-trace.html).
pub const FlowTraceCondition = struct {
    /// The name of the condition.
    condition_name: []const u8,

    pub const json_field_names = .{
        .condition_name = "conditionName",
    };
};
