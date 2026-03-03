const ConfluencePageToIndexFieldMapping = @import("confluence_page_to_index_field_mapping.zig").ConfluencePageToIndexFieldMapping;

/// Configuration of the page settings for the Confluence data source.
pub const ConfluencePageConfiguration = struct {
    /// Maps attributes or field names of Confluence pages to Amazon Kendra index
    /// field
    /// names. To create custom fields, use the `UpdateIndex` API before you map to
    /// Confluence fields. For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// Confluence data source field names must exist in your Confluence custom
    /// metadata.
    ///
    /// If you specify the `PageFieldMappings` parameter, you must specify at least
    /// one field mapping.
    page_field_mappings: ?[]const ConfluencePageToIndexFieldMapping = null,

    pub const json_field_names = .{
        .page_field_mappings = "PageFieldMappings",
    };
};
