const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the pipeline to tag.
    arn: []const u8,

    /// The list of key-value tags to add to the pipeline.
    tags: []const Tag,

    pub const json_field_names = .{
        .arn = "Arn",
        .tags = "Tags",
    };
};
