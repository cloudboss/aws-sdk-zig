pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the resource that's tagged.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
