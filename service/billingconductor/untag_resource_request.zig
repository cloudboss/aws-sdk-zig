pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to which to delete tags.
    resource_arn: []const u8,

    /// The tags to delete from the resource as a list of key-value pairs.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
