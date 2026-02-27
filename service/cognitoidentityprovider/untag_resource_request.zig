pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the user pool that the tags are assigned
    /// to.
    resource_arn: []const u8,

    /// An array of tag keys that you want to remove from the user pool.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
