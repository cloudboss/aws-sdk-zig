pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the resource that you want to list the
    /// tags for.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
