/// The resource policy object. Currently, you can use policies to share
/// snapshots across Amazon Web Services accounts.
pub const ResourcePolicy = struct {
    /// The resource policy.
    policy: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the policy.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "policy",
        .resource_arn = "resourceArn",
    };
};
