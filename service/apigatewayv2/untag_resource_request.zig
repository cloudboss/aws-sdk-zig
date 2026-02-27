pub const UntagResourceRequest = struct {
    /// The resource ARN for the tag.
    resource_arn: []const u8,

    /// The Tag keys to delete
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
