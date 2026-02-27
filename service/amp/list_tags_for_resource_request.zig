pub const ListTagsForResourceRequest = struct {
    /// The ARN of the resource to list tages for. Must be a workspace, scraper, or
    /// rule groups namespace resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
