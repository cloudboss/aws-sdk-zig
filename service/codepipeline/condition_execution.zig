const ConditionExecutionStatus = @import("condition_execution_status.zig").ConditionExecutionStatus;

/// The run of a condition.
pub const ConditionExecution = struct {
    /// The last status change of the condition.
    last_status_change: ?i64,

    /// The status of the run for a condition.
    status: ?ConditionExecutionStatus,

    /// The summary of information about a run for a condition.
    summary: ?[]const u8,

    pub const json_field_names = .{
        .last_status_change = "lastStatusChange",
        .status = "status",
        .summary = "summary",
    };
};
