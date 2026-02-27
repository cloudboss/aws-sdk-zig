const EngagementSortName = @import("engagement_sort_name.zig").EngagementSortName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies the sorting parameters for listing Engagements.
pub const EngagementSort = struct {
    /// The field by which to sort the results.
    sort_by: EngagementSortName,

    /// The order in which to sort the results.
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
