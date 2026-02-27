/// A managed policy that is attached to the IAM group.
pub const AwsIamGroupPolicy = struct {
    /// The name of the policy.
    policy_name: ?[]const u8,

    pub const json_field_names = .{
        .policy_name = "PolicyName",
    };
};
