const AmiProductSortBy = @import("ami_product_sort_by.zig").AmiProductSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Objects that allows sorting on AMI products based on certain fields and
/// sorting order.
pub const AmiProductSort = struct {
    /// Field to sort the AMI products by.
    sort_by: ?AmiProductSortBy,

    /// The sorting order. Can be `ASCENDING` or `DESCENDING`. The default value is
    /// `DESCENDING`.
    sort_order: ?SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
