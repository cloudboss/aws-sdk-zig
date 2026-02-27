pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to list tags for.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
