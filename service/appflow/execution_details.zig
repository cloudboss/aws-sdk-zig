const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// Describes the details of the flow run, including the timestamp, status, and
/// message.
pub const ExecutionDetails = struct {
    /// Describes the details of the most recent flow run.
    most_recent_execution_message: ?[]const u8,

    /// Specifies the status of the most recent flow run.
    most_recent_execution_status: ?ExecutionStatus,

    /// Specifies the time of the most recent flow run.
    most_recent_execution_time: ?i64,

    pub const json_field_names = .{
        .most_recent_execution_message = "mostRecentExecutionMessage",
        .most_recent_execution_status = "mostRecentExecutionStatus",
        .most_recent_execution_time = "mostRecentExecutionTime",
    };
};
