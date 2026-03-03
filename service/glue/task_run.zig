const TaskRunProperties = @import("task_run_properties.zig").TaskRunProperties;
const TaskStatusType = @import("task_status_type.zig").TaskStatusType;

/// The sampling parameters that are associated with the machine learning
/// transform.
pub const TaskRun = struct {
    /// The last point in time that the requested task run was completed.
    completed_on: ?i64 = null,

    /// The list of error strings associated with this task run.
    error_string: ?[]const u8 = null,

    /// The amount of time (in seconds) that the task run consumed resources.
    execution_time: i32 = 0,

    /// The last point in time that the requested task run was updated.
    last_modified_on: ?i64 = null,

    /// The names of the log group for secure logging, associated with this task
    /// run.
    log_group_name: ?[]const u8 = null,

    /// Specifies configuration properties associated with this task run.
    properties: ?TaskRunProperties = null,

    /// The date and time that this task run started.
    started_on: ?i64 = null,

    /// The current status of the requested task run.
    status: ?TaskStatusType = null,

    /// The unique identifier for this task run.
    task_run_id: ?[]const u8 = null,

    /// The unique identifier for the transform.
    transform_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .completed_on = "CompletedOn",
        .error_string = "ErrorString",
        .execution_time = "ExecutionTime",
        .last_modified_on = "LastModifiedOn",
        .log_group_name = "LogGroupName",
        .properties = "Properties",
        .started_on = "StartedOn",
        .status = "Status",
        .task_run_id = "TaskRunId",
        .transform_id = "TransformId",
    };
};
