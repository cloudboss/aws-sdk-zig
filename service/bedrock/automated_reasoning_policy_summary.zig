/// Contains summary information about an Automated Reasoning policy, including
/// metadata and timestamps.
pub const AutomatedReasoningPolicySummary = struct {
    /// The timestamp when the policy was created.
    created_at: i64,

    /// The description of the policy.
    description: ?[]const u8,

    /// The name of the policy.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the policy.
    policy_arn: []const u8,

    /// The unique identifier of the policy.
    policy_id: []const u8,

    /// The timestamp when the policy was last updated.
    updated_at: i64,

    /// The version of the policy.
    version: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .policy_arn = "policyArn",
        .policy_id = "policyId",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
