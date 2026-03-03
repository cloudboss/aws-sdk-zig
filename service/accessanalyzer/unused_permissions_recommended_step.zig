const RecommendedRemediationAction = @import("recommended_remediation_action.zig").RecommendedRemediationAction;

/// Contains information about the action to take for a policy in an unused
/// permissions finding.
pub const UnusedPermissionsRecommendedStep = struct {
    /// If the recommended action for the unused permissions finding is to detach a
    /// policy, the ID of an existing policy to be detached.
    existing_policy_id: ?[]const u8 = null,

    /// The time at which the existing policy for the unused permissions finding was
    /// last updated.
    policy_updated_at: ?i64 = null,

    /// A recommendation of whether to create or detach a policy for an unused
    /// permissions finding.
    recommended_action: RecommendedRemediationAction,

    /// If the recommended action for the unused permissions finding is to replace
    /// the existing policy, the contents of the recommended policy to replace the
    /// policy specified in the `existingPolicyId` field.
    recommended_policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .existing_policy_id = "existingPolicyId",
        .policy_updated_at = "policyUpdatedAt",
        .recommended_action = "recommendedAction",
        .recommended_policy = "recommendedPolicy",
    };
};
