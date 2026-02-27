const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// The reference for the data export update.
pub const ExecutionReference = struct {
    /// The ID for this specific execution.
    execution_id: []const u8,

    /// The status of this specific execution.
    execution_status: ExecutionStatus,

    pub const json_field_names = .{
        .execution_id = "ExecutionId",
        .execution_status = "ExecutionStatus",
    };
};
