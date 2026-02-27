pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource you want to untag.
    resource_arn: []const u8,

    /// Keys of the tags you want to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
