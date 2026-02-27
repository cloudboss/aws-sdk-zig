pub const PutResourcePolicyResponse = struct {
    /// ID of the current policy version.
    policy_hash: ?[]const u8,

    /// The policy ID. To update a policy, you must specify `PolicyId` and
    /// `PolicyHash`.
    policy_id: ?[]const u8,

    pub const json_field_names = .{
        .policy_hash = "PolicyHash",
        .policy_id = "PolicyId",
    };
};
