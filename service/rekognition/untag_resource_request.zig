pub const UntagResourceRequest = struct {
    /// Amazon Resource Name (ARN) of the model, collection, or stream processor
    /// that you want to
    /// remove the tags from.
    resource_arn: []const u8,

    /// A list of the tags that you want to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
