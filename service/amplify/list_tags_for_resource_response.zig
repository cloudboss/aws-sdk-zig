const aws = @import("aws");

/// The response for the list tags for resource request.
pub const ListTagsForResourceResponse = struct {
    /// A list of tags for the specified The Amazon Resource Name (ARN).
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
