pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the pipeline to retrieve tags for.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
