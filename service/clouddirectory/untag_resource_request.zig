pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource. Tagging is only supported
    /// for
    /// directories.
    resource_arn: []const u8,

    /// Keys of the tag that need to be removed from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
