const Tag = @import("tag.zig").Tag;

/// Contains the information that's required to enable a managed Contributor
/// Insights
/// rule for an Amazon Web Services resource.
pub const ManagedRule = struct {
    /// The ARN of an Amazon Web Services resource that has managed Contributor
    /// Insights
    /// rules.
    resource_arn: []const u8,

    /// A list of key-value pairs that you can associate with a managed Contributor
    /// Insights
    /// rule. You can associate as many as 50 tags with a rule. Tags can help you
    /// organize and
    /// categorize your resources. You also can use them to scope user permissions
    /// by granting a
    /// user permission to access or change only the resources that have certain tag
    /// values. To
    /// associate tags with a rule, you must have the `cloudwatch:TagResource`
    /// permission in addition to the `cloudwatch:PutInsightRule` permission. If you
    /// are using this operation to update an existing Contributor Insights rule,
    /// any tags that
    /// you specify in this parameter are ignored. To change the tags of an existing
    /// rule, use
    /// `TagResource`.
    tags: ?[]const Tag = null,

    /// The template name for the managed Contributor Insights rule, as returned by
    /// `ListManagedInsightRules`.
    template_name: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
        .template_name = "TemplateName",
    };
};
