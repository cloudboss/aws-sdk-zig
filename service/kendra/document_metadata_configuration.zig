const Relevance = @import("relevance.zig").Relevance;
const Search = @import("search.zig").Search;
const DocumentAttributeValueType = @import("document_attribute_value_type.zig").DocumentAttributeValueType;

/// Specifies the properties, such as relevance tuning and searchability, of an
/// index
/// field.
pub const DocumentMetadataConfiguration = struct {
    /// The name of the index field.
    name: []const u8,

    /// Provides tuning parameters to determine how the field affects the search
    /// results.
    relevance: ?Relevance = null,

    /// Provides information about how the field is used during a search.
    search: ?Search = null,

    /// The data type of the index field.
    @"type": DocumentAttributeValueType,

    pub const json_field_names = .{
        .name = "Name",
        .relevance = "Relevance",
        .search = "Search",
        .@"type" = "Type",
    };
};
