pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) associated with the resource you want to
    /// remove the tag from.
    resource_arn: []const u8,

    /// A list of key names of tags to be removed.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "tagKeys",
    };
};
