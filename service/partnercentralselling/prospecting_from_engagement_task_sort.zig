const ProspectingFromEngagementTaskSortName = @import("prospecting_from_engagement_task_sort_name.zig").ProspectingFromEngagementTaskSortName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies the sort configuration for `ListProspectingFromEngagementTasks`.
/// Contains the field to sort by and the sort direction.
pub const ProspectingFromEngagementTaskSort = struct {
    /// The field by which to sort the returned tasks. Valid values: `StartTime`
    /// (task creation timestamp), `TaskName` (alphabetically by task name), and
    /// `FailedEngagementCount` (number of failed engagements).
    sort_by: ProspectingFromEngagementTaskSortName,

    /// The direction in which to sort the results. Use `ASCENDING` to return the
    /// smallest or earliest values first, or `DESCENDING` to return the largest or
    /// most recent values first.
    sort_order: SortOrder,

    pub const json_field_names = .{
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};
