const Tag = @import("tag.zig").Tag;

/// Container for the parameters to the `AddTags` operation. Specify the tags
/// that you want to attach to the Elasticsearch domain.
pub const AddTagsRequest = struct {
    /// Specify the `ARN` for which you want to add the tags.
    arn: []const u8,

    /// List of `Tag` that need to be added for the Elasticsearch domain.
    tag_list: []const Tag,

    pub const json_field_names = .{
        .arn = "ARN",
        .tag_list = "TagList",
    };
};
