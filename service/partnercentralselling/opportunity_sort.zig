const OpportunitySortName = @import("opportunity_sort_name.zig").OpportunitySortName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Object that configures response sorting.
pub const OpportunitySort = struct {
    /// Field name to sort by.
    sort_by: OpportunitySortName,

    /// Sort order.
    ///
    /// Default: `Descending`
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
