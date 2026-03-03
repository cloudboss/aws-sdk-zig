/// The specific filters applied to your data source content. You can filter out
/// or include certain content.
pub const PatternObjectFilter = struct {
    /// A list of one or more exclusion regular expression patterns to exclude
    /// certain object types that adhere to the pattern. If you specify an inclusion
    /// and exclusion filter/pattern and both match a document, the exclusion filter
    /// takes precedence and the document isn’t crawled.
    exclusion_filters: ?[]const []const u8 = null,

    /// A list of one or more inclusion regular expression patterns to include
    /// certain object types that adhere to the pattern. If you specify an inclusion
    /// and exclusion filter/pattern and both match a document, the exclusion filter
    /// takes precedence and the document isn’t crawled.
    inclusion_filters: ?[]const []const u8 = null,

    /// The supported object type or content type of the data source.
    object_type: []const u8,

    pub const json_field_names = .{
        .exclusion_filters = "exclusionFilters",
        .inclusion_filters = "inclusionFilters",
        .object_type = "objectType",
    };
};
