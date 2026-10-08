/// A reference to a policy in a create or update request.
pub const PolicyReference = struct {
    /// The identifier of the policy. This is the policy's Amazon Resource Name
    /// (ARN), optionally version-qualified to pin a specific published version.
    policy_identifier: []const u8,

    pub const json_field_names = .{
        .policy_identifier = "policyIdentifier",
    };
};
