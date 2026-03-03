const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The Amazon Resource Name (ARN) specified in your request.
    resource_arn: ?[]const u8 = null,

    /// Lists all tags associated with the given transcription job, vocabulary,
    /// model, or
    /// resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
