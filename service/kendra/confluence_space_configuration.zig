const ConfluenceSpaceToIndexFieldMapping = @import("confluence_space_to_index_field_mapping.zig").ConfluenceSpaceToIndexFieldMapping;

/// Configuration information for indexing Confluence spaces.
pub const ConfluenceSpaceConfiguration = struct {
    /// `TRUE` to index archived spaces.
    crawl_archived_spaces: bool = false,

    /// `TRUE` to index personal spaces. You can add restrictions to items in
    /// personal spaces. If personal spaces are indexed, queries without user
    /// context
    /// information may return restricted items from a personal space in their
    /// results. For more
    /// information, see [Filtering on user
    /// context](https://docs.aws.amazon.com/kendra/latest/dg/user-context-filter.html).
    crawl_personal_spaces: bool = false,

    /// A list of space keys of Confluence spaces. If you include a key, the blogs,
    /// documents,
    /// and attachments in the space are not indexed. If a space is in both the
    /// `ExcludeSpaces` and the `IncludeSpaces` list, the space is
    /// excluded.
    exclude_spaces: ?[]const []const u8 = null,

    /// A list of space keys for Confluence spaces. If you include a key, the blogs,
    /// documents, and attachments in the space are indexed. Spaces that aren't in
    /// the list
    /// aren't indexed. A space in the list must exist. Otherwise, Amazon Kendra
    /// logs an
    /// error when the data source is synchronized. If a space is in both the
    /// `IncludeSpaces` and the `ExcludeSpaces` list, the space is
    /// excluded.
    include_spaces: ?[]const []const u8 = null,

    /// Maps attributes or field names of Confluence spaces to Amazon Kendra index
    /// field
    /// names. To create custom fields, use the `UpdateIndex` API before you map to
    /// Confluence fields. For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// Confluence data source field names must exist in your Confluence custom
    /// metadata.
    ///
    /// If you specify the `SpaceFieldMappings` parameter, you must specify at
    /// least one field mapping.
    space_field_mappings: ?[]const ConfluenceSpaceToIndexFieldMapping = null,

    pub const json_field_names = .{
        .crawl_archived_spaces = "CrawlArchivedSpaces",
        .crawl_personal_spaces = "CrawlPersonalSpaces",
        .exclude_spaces = "ExcludeSpaces",
        .include_spaces = "IncludeSpaces",
        .space_field_mappings = "SpaceFieldMappings",
    };
};
