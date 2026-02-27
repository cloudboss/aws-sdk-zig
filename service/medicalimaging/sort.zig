const SortField = @import("sort_field.zig").SortField;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Sort search results.
pub const Sort = struct {
    /// The sort field for search criteria.
    sort_field: SortField,

    /// The sort order for search criteria.
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_field = "sortField",
        .sort_order = "sortOrder",
    };
};
