const StartServicePeriodTypeSortName = @import("start_service_period_type_sort_name.zig").StartServicePeriodTypeSortName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Sorting options specific to start service period handshakes.
pub const StartServicePeriodTypeSort = struct {
    /// The field to sort by.
    sort_by: StartServicePeriodTypeSortName,

    /// The sort order (ascending or descending).
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
