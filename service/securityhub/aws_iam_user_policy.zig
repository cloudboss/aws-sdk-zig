/// Information about an inline policy that is embedded in the user.
pub const AwsIamUserPolicy = struct {
    /// The name of the policy.
    policy_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_name = "PolicyName",
    };
};
