const ResaleAuthorizationSortBy = @import("resale_authorization_sort_by.zig").ResaleAuthorizationSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Allows to sort ResaleAuthorization.
pub const ResaleAuthorizationSort = struct {
    /// Allows to sort ResaleAuthorization.
    sort_by: ?ResaleAuthorizationSortBy,

    /// Allows to sort ResaleAuthorization.
    sort_order: ?SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
