const RevokeServicePeriodTypeSortName = @import("revoke_service_period_type_sort_name.zig").RevokeServicePeriodTypeSortName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Sorting options specific to revoke service period handshakes.
pub const RevokeServicePeriodTypeSort = struct {
    /// The field to sort by.
    sort_by: RevokeServicePeriodTypeSortName,

    /// The sort order (ascending or descending).
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
