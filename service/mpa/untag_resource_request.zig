pub const UntagResourceRequest = struct {
    /// Amazon Resource Name (ARN) for the resource you want to untag.
    resource_arn: []const u8,

    /// Array of tag key-value pairs that you want to untag.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
