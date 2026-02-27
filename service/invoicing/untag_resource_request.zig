pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) to untag.
    resource_arn: []const u8,

    /// Keys for the tags to be removed.
    resource_tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_tag_keys = "ResourceTagKeys",
    };
};
