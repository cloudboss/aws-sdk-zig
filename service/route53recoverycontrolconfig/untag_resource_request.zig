pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the resource that's tagged.
    resource_arn: []const u8,

    /// Keys for the tags to be removed.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
