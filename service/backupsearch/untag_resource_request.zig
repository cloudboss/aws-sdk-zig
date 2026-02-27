pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the resource where
    /// you want to remove tags.
    resource_arn: []const u8,

    /// This required parameter contains the tag keys you want to remove from the
    /// source.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
