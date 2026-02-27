/// An inline policy that is embedded in the role.
pub const AwsIamRolePolicy = struct {
    /// The name of the policy.
    policy_name: ?[]const u8,

    pub const json_field_names = .{
        .policy_name = "PolicyName",
    };
};
