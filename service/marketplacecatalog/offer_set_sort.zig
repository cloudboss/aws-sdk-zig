const OfferSetSortBy = @import("offer_set_sort_by.zig").OfferSetSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Allows to sort offer sets.
pub const OfferSetSort = struct {
    /// Allows to sort offer sets.
    sort_by: ?OfferSetSortBy,

    /// Allows to sort offer sets.
    sort_order: ?SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
