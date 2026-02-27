/// Represents a condition that was satisfied during a condition node evaluation
/// in a flow execution.
///
/// Flow executions is in preview release for Amazon Bedrock and is subject to
/// change.
pub const SatisfiedCondition = struct {
    /// The name of the condition that was satisfied.
    condition_name: []const u8,

    pub const json_field_names = .{
        .condition_name = "conditionName",
    };
};
