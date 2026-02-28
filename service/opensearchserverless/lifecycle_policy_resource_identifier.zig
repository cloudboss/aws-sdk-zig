const LifecyclePolicyType = @import("lifecycle_policy_type.zig").LifecyclePolicyType;

/// The unique identifiers of policy types and resource names.
pub const LifecyclePolicyResourceIdentifier = struct {
    /// The name of the OpenSearch Serverless ilndex resource.
    resource: []const u8,

    /// The type of lifecycle policy.
    @"type": LifecyclePolicyType,

    pub const json_field_names = .{
        .resource = "resource",
        .@"type" = "type",
    };
};
