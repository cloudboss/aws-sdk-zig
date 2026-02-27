const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The Amazon Resource Name (ARN) specified in your request.
    resource_arn: ?[]const u8,

    /// Lists all tags associated with the given transcription job, vocabulary,
    /// model, or
    /// resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
