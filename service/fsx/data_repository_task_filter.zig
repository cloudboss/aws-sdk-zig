const DataRepositoryTaskFilterName = @import("data_repository_task_filter_name.zig").DataRepositoryTaskFilterName;

/// (Optional) An array of filter objects you can use to filter the response of
/// data repository tasks you will see in the response.
/// You can filter the tasks returned in the response by one or more file system
/// IDs, task lifecycles, and by task type.
/// A filter object consists of a filter `Name`, and one or more `Values` for
/// the filter.
pub const DataRepositoryTaskFilter = struct {
    /// Name of the task property to use in filtering the tasks returned in the
    /// response.
    ///
    /// * Use `file-system-id` to retrieve data repository tasks for specific file
    ///   systems.
    ///
    /// * Use `task-lifecycle` to retrieve data repository tasks with one or more
    ///   specific lifecycle states,
    /// as follows: CANCELED, EXECUTING, FAILED, PENDING, and SUCCEEDED.
    name: ?DataRepositoryTaskFilterName = null,

    /// Use Values to include the specific file system IDs and task
    /// lifecycle states for the filters you are using.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
