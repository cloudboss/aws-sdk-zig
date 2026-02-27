pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to which the tags are to be
    /// removed.
    resource_arn: []const u8,

    /// The list of keys of the tags that are to be removed.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
