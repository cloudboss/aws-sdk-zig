const StepStatus = @import("step_status.zig").StepStatus;
const ExecutionMode = @import("execution_mode.zig").ExecutionMode;

/// Represents the state of a step in a plan execution.
pub const StepState = struct {
    /// The timestamp when a step endeded execution.
    end_time: ?i64,

    /// The name of a step in a workflow.
    name: ?[]const u8,

    /// The timestamp when a step started execution.
    start_time: ?i64,

    /// The status of a step in a workflow. For example, a status might be Completed
    /// or Pending Approval.
    status: ?StepStatus,

    /// The mode for a step execution. The mode can be Graceful or Ungraceful.
    step_mode: ?ExecutionMode,

    pub const json_field_names = .{
        .end_time = "endTime",
        .name = "name",
        .start_time = "startTime",
        .status = "status",
        .step_mode = "stepMode",
    };
};
