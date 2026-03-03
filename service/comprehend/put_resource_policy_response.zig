pub const PutResourcePolicyResponse = struct {
    /// The revision ID of the policy. Each time you modify a policy, Amazon
    /// Comprehend assigns a
    /// new revision ID, and it deletes the prior version of the policy.
    policy_revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_revision_id = "PolicyRevisionId",
    };
};
