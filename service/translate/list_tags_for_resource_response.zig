const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// Tags associated with the Amazon Translate resource being queried. A tag is a
    /// key-value
    /// pair that adds as a metadata to a resource used by Amazon Translate. For
    /// example, a tag with
    /// "Sales" as the key might be added to a resource to indicate its use by the
    /// sales department.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
