const SolutionSortName = @import("solution_sort_name.zig").SolutionSortName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Configures the solutions' response sorting that enables partners to order
/// solutions based on specified attributes.
pub const SolutionSort = struct {
    /// Specifies the attribute to sort by, such as `Name`, `CreatedDate`, or
    /// `Status`.
    sort_by: SolutionSortName,

    /// Specifies the sorting order, either `Ascending` or `Descending`. The default
    /// is `Descending`.
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
