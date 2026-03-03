/// References a specific automated reasoning policy rule that was applied
/// during evaluation.
pub const AutomatedReasoningCheckRule = struct {
    /// The unique identifier of the automated reasoning rule.
    id: ?[]const u8 = null,

    /// The ARN of the automated reasoning policy version that contains this rule.
    policy_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .policy_version_arn = "policyVersionArn",
    };
};
