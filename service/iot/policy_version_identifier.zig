/// Information about the version of the policy associated with the resource.
pub const PolicyVersionIdentifier = struct {
    /// The name of the policy.
    policy_name: ?[]const u8,

    /// The ID of the version of the policy associated with the resource.
    policy_version_id: ?[]const u8,

    pub const json_field_names = .{
        .policy_name = "policyName",
        .policy_version_id = "policyVersionId",
    };
};
