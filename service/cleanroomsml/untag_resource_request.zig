pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to remove tags
    /// from.
    resource_arn: []const u8,

    /// The key values of tags that you want to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
