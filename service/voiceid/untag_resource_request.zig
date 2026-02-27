pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Voice ID resource you want to remove
    /// tags
    /// from.
    resource_arn: []const u8,

    /// The list of tag keys you want to remove from the specified resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
