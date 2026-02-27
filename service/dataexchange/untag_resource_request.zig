pub const UntagResourceRequest = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies an AWS resource.
    resource_arn: []const u8,

    /// The key tags.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
