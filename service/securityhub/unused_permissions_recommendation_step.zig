/// Contains information about the action to take for a policy in an unused
/// permissions finding.
pub const UnusedPermissionsRecommendationStep = struct {
    /// The contents of the existing policy identified by `ExistingPolicyId` which
    /// needs to be replaced,
    /// when the `RecommendedAction` is `CREATE_POLICY`.
    existing_policy: ?[]const u8 = null,

    /// The ID of an existing policy to be replaced or detached.
    existing_policy_id: ?[]const u8 = null,

    /// The time at which the existing policy for the unused permissions finding was
    /// last updated.
    policy_updated_at: ?i64 = null,

    /// A recommendation of whether to create or detach a policy for an unused
    /// permissions finding.
    recommended_action: ?[]const u8 = null,

    /// The contents of the least-privileged recommended replacement for
    /// `ExistingPolicyId`,
    /// when the `RecommendedAction` is `CREATE_POLICY`.
    recommended_policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .existing_policy = "ExistingPolicy",
        .existing_policy_id = "ExistingPolicyId",
        .policy_updated_at = "PolicyUpdatedAt",
        .recommended_action = "RecommendedAction",
        .recommended_policy = "RecommendedPolicy",
    };
};
