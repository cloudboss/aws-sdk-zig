const aws = @import("aws");

const ErrorInfo = @import("error_info.zig").ErrorInfo;
const TaskStatus = @import("task_status.zig").TaskStatus;

/// Gets the details of a network operation.
///
/// A network operation is any operation that is done to your network, such as
/// network instance instantiation or termination.
pub const GetSolNetworkOperationTaskDetails = struct {
    /// Context for the network operation task.
    task_context: ?[]const aws.map.StringMapEntry,

    /// Task end time.
    task_end_time: ?i64,

    /// Task error details.
    task_error_details: ?ErrorInfo,

    /// Task name.
    task_name: ?[]const u8,

    /// Task start time.
    task_start_time: ?i64,

    /// Task status.
    task_status: ?TaskStatus,

    pub const json_field_names = .{
        .task_context = "taskContext",
        .task_end_time = "taskEndTime",
        .task_error_details = "taskErrorDetails",
        .task_name = "taskName",
        .task_start_time = "taskStartTime",
        .task_status = "taskStatus",
    };
};
