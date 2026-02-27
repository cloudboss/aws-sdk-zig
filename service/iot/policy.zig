/// Describes an IoT policy.
pub const Policy = struct {
    /// The policy ARN.
    policy_arn: ?[]const u8,

    /// The policy name.
    policy_name: ?[]const u8,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
        .policy_name = "policyName",
    };
};
