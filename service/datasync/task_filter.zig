const TaskFilterName = @import("task_filter_name.zig").TaskFilterName;
const Operator = @import("operator.zig").Operator;

/// You can use API filters to narrow down the list of resources returned by
/// `ListTasks`. For example, to retrieve all tasks on a source location, you
/// can use
/// `ListTasks` with filter name `LocationId` and `Operator
/// Equals` with the ARN for the location.
///
/// For more information, see [filtering DataSync
/// resources](https://docs.aws.amazon.com/datasync/latest/userguide/query-resources.html).
pub const TaskFilter = struct {
    /// The name of the filter being used. Each API call supports a list of filters
    /// that are
    /// available for it. For example, `LocationId` for `ListTasks`.
    name: TaskFilterName,

    /// The operator that is used to compare filter values (for example, `Equals` or
    /// `Contains`).
    operator: Operator,

    /// The values that you want to filter for. For example, you might want to
    /// display only tasks
    /// for a specific destination location.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .values = "Values",
    };
};
