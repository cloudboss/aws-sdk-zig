const ConfluenceBlogToIndexFieldMapping = @import("confluence_blog_to_index_field_mapping.zig").ConfluenceBlogToIndexFieldMapping;

/// Configuration of blog settings for the Confluence data source. Blogs are
/// always
/// indexed unless filtered from the index by the `ExclusionPatterns` or
/// `InclusionPatterns` fields in the `ConfluenceConfiguration`
/// object.
pub const ConfluenceBlogConfiguration = struct {
    /// Maps attributes or field names of Confluence blogs to Amazon Kendra index
    /// field
    /// names. To create custom fields, use the `UpdateIndex` API before you map to
    /// Confluence fields. For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// Confluence data source field names must exist in your Confluence custom
    /// metadata.
    ///
    /// If you specify the `BlogFieldMappings` parameter, you must specify at least
    /// one field mapping.
    blog_field_mappings: ?[]const ConfluenceBlogToIndexFieldMapping = null,

    pub const json_field_names = .{
        .blog_field_mappings = "BlogFieldMappings",
    };
};
