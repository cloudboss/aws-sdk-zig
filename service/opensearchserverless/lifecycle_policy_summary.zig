const LifecyclePolicyType = @import("lifecycle_policy_type.zig").LifecyclePolicyType;

/// A summary of the lifecycle policy.
pub const LifecyclePolicySummary = struct {
    /// The Epoch time when the lifecycle policy was created.
    created_date: ?i64,

    /// The description of the lifecycle policy.
    description: ?[]const u8,

    /// The date and time when the lifecycle policy was last modified.
    last_modified_date: ?i64,

    /// The name of the lifecycle policy.
    name: ?[]const u8,

    /// The version of the lifecycle policy.
    policy_version: ?[]const u8,

    /// The type of lifecycle policy.
    type: ?LifecyclePolicyType,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .description = "description",
        .last_modified_date = "lastModifiedDate",
        .name = "name",
        .policy_version = "policyVersion",
        .type = "type",
    };
};
