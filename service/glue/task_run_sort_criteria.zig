const TaskRunSortColumnType = @import("task_run_sort_column_type.zig").TaskRunSortColumnType;
const SortDirectionType = @import("sort_direction_type.zig").SortDirectionType;

/// The sorting criteria that are used to sort the list of task runs for the
/// machine learning
/// transform.
pub const TaskRunSortCriteria = struct {
    /// The column to be used to sort the list of task runs for the machine learning
    /// transform.
    column: TaskRunSortColumnType,

    /// The sort direction to be used to sort the list of task runs for the machine
    /// learning
    /// transform.
    sort_direction: SortDirectionType,

    pub const json_field_names = .{
        .column = "Column",
        .sort_direction = "SortDirection",
    };
};
