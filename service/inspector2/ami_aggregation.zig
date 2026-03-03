const StringFilter = @import("string_filter.zig").StringFilter;
const AmiSortBy = @import("ami_sort_by.zig").AmiSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The details that define an aggregation based on Amazon machine images
/// (AMIs).
pub const AmiAggregation = struct {
    /// The IDs of AMIs to aggregate findings for.
    amis: ?[]const StringFilter = null,

    /// The value to sort results by.
    sort_by: ?AmiSortBy = null,

    /// The order to sort results by.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .amis = "amis",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
