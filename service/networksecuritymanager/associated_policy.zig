/// An association between a deployment and a policy, as returned in outputs.
/// The corresponding request structure is `PolicyReference`.
pub const AssociatedPolicy = struct {
    /// The ARN of the associated policy, including its version qualifier when a
    /// specific published version is pinned (for example, `...:policy:abc123:3`).
    policy_arn: []const u8,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
    };
};
