const SearchFilter = @import("search_filter.zig").SearchFilter;
const Sort = @import("sort.zig").Sort;

/// The search criteria.
pub const SearchCriteria = struct {
    /// The filters for the search criteria.
    filters: ?[]const SearchFilter = null,

    /// The sort input for search criteria.
    sort: ?Sort = null,

    pub const json_field_names = .{
        .filters = "filters",
        .sort = "sort",
    };
};
