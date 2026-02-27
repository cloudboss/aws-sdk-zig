const PolicyScope = @import("policy_scope.zig").PolicyScope;

/// A policy enabling one or more entities to put logs to a log group in this
/// account.
pub const ResourcePolicy = struct {
    /// Timestamp showing when this policy was last updated, expressed as the number
    /// of
    /// milliseconds after `Jan 1, 1970 00:00:00 UTC`.
    last_updated_time: ?i64,

    /// The details of the policy.
    policy_document: ?[]const u8,

    /// The name of the resource policy.
    policy_name: ?[]const u8,

    /// Specifies scope of the resource policy. Valid values are ACCOUNT or
    /// RESOURCE.
    policy_scope: ?PolicyScope,

    /// The ARN of the CloudWatch Logs resource to which the resource policy is
    /// attached. Only
    /// populated for resource-scoped policies.
    resource_arn: ?[]const u8,

    /// The revision ID of the resource policy. Only populated for resource-scoped
    /// policies.
    revision_id: ?[]const u8,

    pub const json_field_names = .{
        .last_updated_time = "lastUpdatedTime",
        .policy_document = "policyDocument",
        .policy_name = "policyName",
        .policy_scope = "policyScope",
        .resource_arn = "resourceArn",
        .revision_id = "revisionId",
    };
};
