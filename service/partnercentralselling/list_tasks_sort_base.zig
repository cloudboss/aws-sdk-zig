const ListTasksSortName = @import("list_tasks_sort_name.zig").ListTasksSortName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Defines the sorting parameters for listing tasks. This structure allows for
/// specifying the field to sort by and the order of sorting.
pub const ListTasksSortBase = struct {
    /// Specifies the field by which the task list should be sorted.
    sort_by: ListTasksSortName,

    /// Determines the order in which the sorted results are presented.
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
