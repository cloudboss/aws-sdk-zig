pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
