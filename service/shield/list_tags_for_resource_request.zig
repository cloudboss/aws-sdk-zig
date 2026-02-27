pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to get tags for.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
