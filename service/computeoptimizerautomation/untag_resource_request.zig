pub const UntagResourceRequest = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. Must be 1-64 characters long and contain only
    /// alphanumeric characters, underscores, and hyphens.
    client_token: ?[]const u8 = null,

    /// The ARN of the resource to untag.
    resource_arn: []const u8,

    /// The revision number of the automation rule to untag. This ensures you're
    /// untagging the correct version of the rule.
    rule_revision: i64,

    /// The keys of the tags to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .resource_arn = "resourceArn",
        .rule_revision = "ruleRevision",
        .tag_keys = "tagKeys",
    };
};
