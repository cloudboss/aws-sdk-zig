const OrderByFieldType = @import("order_by_field_type.zig").OrderByFieldType;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The result of the sort operation.
pub const SearchSortResult = struct {
    /// Sort search results based on this field name.
    field: ?OrderByFieldType,

    /// Sort direction.
    order: ?SortOrder,

    pub const json_field_names = .{
        .field = "Field",
        .order = "Order",
    };
};
