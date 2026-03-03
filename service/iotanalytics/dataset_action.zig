const ContainerDatasetAction = @import("container_dataset_action.zig").ContainerDatasetAction;
const SqlQueryDatasetAction = @import("sql_query_dataset_action.zig").SqlQueryDatasetAction;

/// A `DatasetAction` object that specifies how dataset contents are
/// automatically
/// created.
pub const DatasetAction = struct {
    /// The name of the dataset action by which dataset contents are automatically
    /// created.
    action_name: ?[]const u8 = null,

    /// Information that allows the system to run a containerized application to
    /// create the
    /// dataset contents. The application must be in a Docker container along with
    /// any required
    /// support libraries.
    container_action: ?ContainerDatasetAction = null,

    /// An `SqlQueryDatasetAction` object that uses an SQL query to automatically
    /// create dataset contents.
    query_action: ?SqlQueryDatasetAction = null,

    pub const json_field_names = .{
        .action_name = "actionName",
        .container_action = "containerAction",
        .query_action = "queryAction",
    };
};
