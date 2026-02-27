const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the applied quota. You can get this
    /// information by
    /// using the Service Quotas console, or by listing the quotas using the
    /// [list-service-quotas](https://docs.aws.amazon.com/cli/latest/reference/service-quotas/list-service-quotas.html) CLI command or the [ListServiceQuotas](https://docs.aws.amazon.com/servicequotas/2019-06-24/apireference/API_ListServiceQuotas.html) Amazon Web Services API operation.
    resource_arn: []const u8,

    /// The tags that you want to add to the resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
