pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) to use to list tags.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
