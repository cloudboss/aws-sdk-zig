const AccessPolicyType = @import("access_policy_type.zig").AccessPolicyType;

/// Details about an OpenSearch Serverless access policy.
pub const AccessPolicyDetail = struct {
    /// The date the policy was created.
    created_date: ?i64 = null,

    /// The description of the policy.
    description: ?[]const u8 = null,

    /// The timestamp of when the policy was last modified.
    last_modified_date: ?i64 = null,

    /// The name of the policy.
    name: ?[]const u8 = null,

    /// The JSON policy document without any whitespaces.
    policy: ?[]const u8 = null,

    /// The version of the policy.
    policy_version: ?[]const u8 = null,

    /// The type of access policy.
    @"type": ?AccessPolicyType = null,

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
