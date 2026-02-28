const AccessPolicyType = @import("access_policy_type.zig").AccessPolicyType;

/// A summary of the data access policy.
pub const AccessPolicySummary = struct {
    /// The Epoch time when the access policy was created.
    created_date: ?i64,

    /// The description of the access policy.
    description: ?[]const u8,

    /// The date and time when the collection was last modified.
    last_modified_date: ?i64,

    /// The name of the access policy.
    name: ?[]const u8,

    /// The version of the policy.
    policy_version: ?[]const u8,

    /// The type of access policy. Currently, the only available type is `data`.
    @"type": ?AccessPolicyType,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .description = "description",
        .last_modified_date = "lastModifiedDate",
        .name = "name",
        .policy_version = "policyVersion",
        .@"type" = "type",
    };
};
