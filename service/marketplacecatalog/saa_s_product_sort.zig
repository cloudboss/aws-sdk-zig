const SaaSProductSortBy = @import("saa_s_product_sort_by.zig").SaaSProductSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Objects that allows sorting on SaaS products based on certain fields and
/// sorting order.
pub const SaaSProductSort = struct {
    /// Field to sort the SaaS products by.
    sort_by: ?SaaSProductSortBy,

    /// The sorting order. Can be `ASCENDING` or `DESCENDING`. The default value is
    /// `DESCENDING`.
    sort_order: ?SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
