pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that identifies the MediaConnect resource for
    /// which to list the tags.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
