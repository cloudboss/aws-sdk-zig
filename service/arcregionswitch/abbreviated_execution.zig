const ExecutionAction = @import("execution_action.zig").ExecutionAction;
const ExecutionState = @import("execution_state.zig").ExecutionState;
const ExecutionMode = @import("execution_mode.zig").ExecutionMode;

/// A summarized representation of a plan execution. This structure contains key
/// information about an execution without all the detailed step data.
pub const AbbreviatedExecution = struct {
    /// The actual recovery time that Region switch calculates for a plan execution.
    /// Actual recovery time includes the time for the plan to run added to the time
    /// elapsed until the application health alarms that you've specified are
    /// healthy again.
    actual_recovery_time: ?[]const u8 = null,

    /// An optional comment about the plan execution.
    comment: ?[]const u8 = null,

    /// The timestamp when the plan execution was ended.
    end_time: ?i64 = null,

    /// The plan execution action. Valid values are `activate`, to activate an
    /// Amazon Web Services Region, or `deactivate`, to deactivate a Region.
    execution_action: ExecutionAction,

    /// The execution identifier of a plan execution.
    execution_id: []const u8,

    /// The Amazon Web Services Region for a plan execution.
    execution_region: []const u8,

    /// The plan execution state. Provides the state of a plan execution, for
    /// example, In Progress or Paused by Operator.
    execution_state: ExecutionState,

    /// The plan execution mode. Valid values are `graceful`, for graceful
    /// executions, or `ungraceful`, for ungraceful executions.
    mode: ExecutionMode,

    /// The Amazon Resource Name (ARN) of the plan.
    plan_arn: []const u8,

    /// The timestamp when the plan execution was started.
    start_time: i64,

    /// The timestamp when the plan execution was last updated.
    updated_at: ?i64 = null,

    /// The version for the plan.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .actual_recovery_time = "actualRecoveryTime",
        .comment = "comment",
        .end_time = "endTime",
        .execution_action = "executionAction",
        .execution_id = "executionId",
        .execution_region = "executionRegion",
        .execution_state = "executionState",
        .mode = "mode",
        .plan_arn = "planArn",
        .start_time = "startTime",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
