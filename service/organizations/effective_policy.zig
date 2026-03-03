const EffectivePolicyType = @import("effective_policy_type.zig").EffectivePolicyType;

/// Contains rules to be applied to the affected accounts. The effective policy
/// is the
/// aggregation of any policies the account inherits, plus any policy directly
/// attached to
/// the account.
pub const EffectivePolicy = struct {
    /// The time of the last update to this policy.
    last_updated_timestamp: ?i64 = null,

    /// The text content of the policy.
    policy_content: ?[]const u8 = null,

    /// The policy type.
    policy_type: ?EffectivePolicyType = null,

    /// The account ID of the policy target.
    target_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .policy_content = "PolicyContent",
        .policy_type = "PolicyType",
        .target_id = "TargetId",
    };
};
