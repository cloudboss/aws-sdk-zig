pub const ListTagsForResourceRequest = struct {
    /// Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
