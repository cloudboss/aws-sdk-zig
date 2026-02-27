pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN)
    arn: []const u8,

    /// List of tag keys.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .tag_keys = "tagKeys",
    };
};
