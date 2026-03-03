/// References a specific automated reasoning policy rule that was applied
/// during evaluation.
pub const GuardrailAutomatedReasoningRule = struct {
    /// The unique identifier of the automated reasoning rule.
    identifier: ?[]const u8 = null,

    /// The ARN of the automated reasoning policy version that contains this rule.
    policy_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .identifier = "identifier",
        .policy_version_arn = "policyVersionArn",
    };
};
