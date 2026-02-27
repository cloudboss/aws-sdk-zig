pub const UntagResourceRequest = struct {
    resource_arn: []const u8,

    /// The key(s) of tag to be deleted
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
