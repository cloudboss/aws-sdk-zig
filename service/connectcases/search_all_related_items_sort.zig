const Order = @import("order.zig").Order;
const SearchAllRelatedItemsSortProperty = @import("search_all_related_items_sort_property.zig").SearchAllRelatedItemsSortProperty;

/// The order in which all returned related items should be sorted.
pub const SearchAllRelatedItemsSort = struct {
    /// Whether related items should be sorted by association time or case ID.
    sort_order: Order,

    /// Whether related items should be sorted in ascending or descending order.
    sort_property: SearchAllRelatedItemsSortProperty,

    pub const json_field_names = .{
        .sort_order = "sortOrder",
        .sort_property = "sortProperty",
    };
};
