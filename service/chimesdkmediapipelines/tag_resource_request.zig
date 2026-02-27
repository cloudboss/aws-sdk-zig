const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The ARN of the media pipeline associated with any tags. The ARN consists of
    /// the pipeline's endpoint region, resource ID, and pipeline ID.
    resource_arn: []const u8,

    /// The tags associated with the specified media pipeline.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
