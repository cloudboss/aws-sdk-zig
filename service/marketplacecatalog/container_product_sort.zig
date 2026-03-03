const ContainerProductSortBy = @import("container_product_sort_by.zig").ContainerProductSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Objects that allows sorting on container products based on certain fields
/// and sorting order.
pub const ContainerProductSort = struct {
    /// Field to sort the container products by.
    sort_by: ?ContainerProductSortBy = null,

    /// The sorting order. Can be `ASCENDING` or `DESCENDING`. The default value is
    /// `DESCENDING`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
