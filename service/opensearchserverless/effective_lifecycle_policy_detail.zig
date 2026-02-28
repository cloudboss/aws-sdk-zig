const ResourceType = @import("resource_type.zig").ResourceType;
const LifecyclePolicyType = @import("lifecycle_policy_type.zig").LifecyclePolicyType;

/// Error information for an OpenSearch Serverless request.
pub const EffectiveLifecyclePolicyDetail = struct {
    /// The minimum number of index retention days set. That is an optional param
    /// that will return as `true` if the minimum number of days or hours is not set
    /// to a index resource.
    no_min_retention_period: ?bool,

    /// The name of the lifecycle policy.
    policy_name: ?[]const u8,

    /// The name of the OpenSearch Serverless index resource.
    resource: ?[]const u8,

    /// The type of OpenSearch Serverless resource. Currently, the only supported
    /// resource is `index`.
    resource_type: ?ResourceType,

    /// The minimum number of index retention in days or hours. This is an optional
    /// parameter that will return only if it’s set.
    retention_period: ?[]const u8,

    /// The type of lifecycle policy.
    @"type": ?LifecyclePolicyType,

    pub const json_field_names = .{
        .no_min_retention_period = "noMinRetentionPeriod",
        .policy_name = "policyName",
        .resource = "resource",
        .resource_type = "resourceType",
        .retention_period = "retentionPeriod",
        .@"type" = "type",
    };
};
