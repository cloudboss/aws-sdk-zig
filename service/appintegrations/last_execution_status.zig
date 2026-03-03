const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// The execution status of the last job.
pub const LastExecutionStatus = struct {
    /// The job status enum string.
    execution_status: ?ExecutionStatus = null,

    /// The status message of a job.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .execution_status = "ExecutionStatus",
        .status_message = "StatusMessage",
    };
};
