const ConditionExecutionStatus = @import("condition_execution_status.zig").ConditionExecutionStatus;

/// Represents information about the run of a condition for a stage.
pub const StageConditionsExecution = struct {
    /// The status of a run of a condition for a stage.
    status: ?ConditionExecutionStatus = null,

    /// A summary of the run of the condition for a stage.
    summary: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "status",
        .summary = "summary",
    };
};
