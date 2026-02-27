/// A managed policy that is attached to an IAM principal.
pub const AwsIamAttachedManagedPolicy = struct {
    /// The ARN of the policy.
    policy_arn: ?[]const u8,

    /// The name of the policy.
    policy_name: ?[]const u8,

    pub const json_field_names = .{
        .policy_arn = "PolicyArn",
        .policy_name = "PolicyName",
    };
};
