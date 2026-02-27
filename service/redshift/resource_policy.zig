/// The policy that is attached to a resource.
pub const ResourcePolicy = struct {
    /// The content of a resource policy.
    policy: ?[]const u8,

    /// The resources that a policy is attached to.
    resource_arn: ?[]const u8,
};
