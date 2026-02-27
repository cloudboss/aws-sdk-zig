/// The summary of the current service revision configuration
pub const ServiceCurrentRevisionSummary = struct {
    /// The ARN of the current service revision.
    arn: ?[]const u8,

    /// The number of pending tasks in the current service revision
    pending_task_count: i32 = 0,

    /// The number of requested tasks in the current service revision
    requested_task_count: i32 = 0,

    /// The number of running tasks of the current service revision
    running_task_count: i32 = 0,

    pub const json_field_names = .{
        .arn = "arn",
        .pending_task_count = "pendingTaskCount",
        .requested_task_count = "requestedTaskCount",
        .running_task_count = "runningTaskCount",
    };
};
