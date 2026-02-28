const LifecyclePolicyType = @import("lifecycle_policy_type.zig").LifecyclePolicyType;

/// Details about an OpenSearch Serverless lifecycle policy.
pub const LifecyclePolicyDetail = struct {
    /// The date the lifecycle policy was created.
    created_date: ?i64,

    /// The description of the lifecycle policy.
    description: ?[]const u8,

    /// The timestamp of when the lifecycle policy was last modified.
    last_modified_date: ?i64,

    /// The name of the lifecycle policy.
    name: ?[]const u8,

    /// The JSON policy document without any whitespaces.
    policy: ?[]const u8,

    /// The version of the lifecycle policy.
    policy_version: ?[]const u8,

    /// The type of lifecycle policy.
    @"type": ?LifecyclePolicyType,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .description = "description",
        .last_modified_date = "lastModifiedDate",
        .name = "name",
        .policy = "policy",
        .policy_version = "policyVersion",
        .@"type" = "type",
    };
};
