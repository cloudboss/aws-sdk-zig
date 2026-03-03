const DataProductSortBy = @import("data_product_sort_by.zig").DataProductSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Objects that allows sorting on data products based on certain fields and
/// sorting order.
pub const DataProductSort = struct {
    /// Field to sort the data products by.
    sort_by: ?DataProductSortBy = null,

    /// The sorting order. Can be `ASCENDING` or `DESCENDING`. The default value is
    /// `DESCENDING`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
