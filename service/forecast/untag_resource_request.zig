pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that identifies the resource for which to
    /// list the tags.
    resource_arn: []const u8,

    /// The keys of the tags to be removed.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
