const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. Must be 1-64 characters long and contain only
    /// alphanumeric characters, underscores, and hyphens.
    client_token: ?[]const u8 = null,

    /// The ARN of the resource to tag.
    resource_arn: []const u8,

    /// The revision number of the automation rule to tag. This ensures you're
    /// tagging the correct version of the rule.
    rule_revision: i64,

    /// The tags to add to the resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .resource_arn = "resourceArn",
        .rule_revision = "ruleRevision",
        .tags = "tags",
    };
};
