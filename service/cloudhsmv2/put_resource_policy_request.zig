pub const PutResourcePolicyRequest = struct {
    /// The policy you want to associate with a resource.
    ///
    /// For an example policy, see [ Working with shared
    /// backups](https://docs.aws.amazon.com/cloudhsm/latest/userguide/sharing.html)
    /// in the CloudHSM User Guide
    policy: ?[]const u8,

    /// Amazon Resource Name (ARN) of the resource to which you want to attach a
    /// policy.
    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};
