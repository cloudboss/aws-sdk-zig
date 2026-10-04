const SearchAttributeFilter = @import("search_attribute_filter.zig").SearchAttributeFilter;
const SearchMapFilter = @import("search_map_filter.zig").SearchMapFilter;

/// A filter clause that supports nested boolean logic. Exactly one of
/// `andAllFilters`, `orAnyFilters`, `attributeFilter`, or `mapFilter` must be
/// specified.
pub const SearchFilterClause = union(enum) {
    /// A list of filter clauses that must all match (logical AND).
    and_all_filters: ?[]const SearchFilterClause,
    /// A filter on a single attribute value.
    attribute_filter: ?SearchAttributeFilter,
    /// A filter on a map attribute's key-value pair.
    map_filter: ?SearchMapFilter,
    /// A list of filter clauses where at least one must match (logical OR).
    or_any_filters: ?[]const SearchFilterClause,

    pub const json_field_names = .{
        .and_all_filters = "AndAllFilters",
        .attribute_filter = "AttributeFilter",
        .map_filter = "MapFilter",
        .or_any_filters = "OrAnyFilters",
    };
};
