const SearchSortOrder = @import("search_sort_order.zig").SearchSortOrder;

/// The sort criteria for search results.
pub const SearchSort = struct {
    /// The attribute to sort by.
    attribute: []const u8,

    /// The sort order. Valid values are `ASCENDING` and `DESCENDING`.
    order: ?SearchSortOrder = null,

    pub const json_field_names = .{
        .attribute = "Attribute",
        .order = "Order",
    };
};
