pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the pipeline to remove tags from.
    arn: []const u8,

    /// The tag keys to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .tag_keys = "TagKeys",
    };
};
