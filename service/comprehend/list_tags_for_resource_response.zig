const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The Amazon Resource Name (ARN) of the given Amazon Comprehend resource you
    /// are
    /// querying.
    resource_arn: ?[]const u8 = null,

    /// Tags associated with the Amazon Comprehend resource being queried. A tag is
    /// a key-value
    /// pair that adds as a metadata to a resource used by Amazon Comprehend. For
    /// example, a tag with
    /// "Sales" as the key might be added to a resource to indicate its use by the
    /// sales department.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
