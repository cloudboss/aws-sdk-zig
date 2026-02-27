const OfferSortBy = @import("offer_sort_by.zig").OfferSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Allows to sort offers.
pub const OfferSort = struct {
    /// Allows to sort offers.
    sort_by: ?OfferSortBy,

    /// Allows to sort offers.
    sort_order: ?SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
