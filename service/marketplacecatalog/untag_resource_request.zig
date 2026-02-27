pub const UntagResourceRequest = struct {
    /// Required. The Amazon Resource Name (ARN) associated with the resource you
    /// want to
    /// remove the tag from.
    resource_arn: []const u8,

    /// Required. A list of key names of tags to be removed. Number of strings
    /// allowed:
    /// 0-256.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
