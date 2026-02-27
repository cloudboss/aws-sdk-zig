pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the notification rule from which to remove
    /// the
    /// tags.
    arn: []const u8,

    /// The key names of the tags to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .tag_keys = "TagKeys",
    };
};
