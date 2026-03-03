const SortBy = @import("sort_by.zig").SortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Defines the sorting parameters for listing resource snapshot jobs. This
/// structure allows you to specify the field to sort by and the order of
/// sorting.
pub const SortObject = struct {
    /// Specifies the field by which to sort the resource snapshot jobs.
    sort_by: ?SortBy = null,

    /// Determines the order in which the sorted results are presented.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
