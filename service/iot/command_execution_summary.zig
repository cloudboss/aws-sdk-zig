const CommandExecutionStatus = @import("command_execution_status.zig").CommandExecutionStatus;

/// Summary information about a particular command execution.
pub const CommandExecutionSummary = struct {
    /// The Amazon Resource Name (ARN) of the command execution.
    command_arn: ?[]const u8 = null,

    /// The date and time at which the command completed executing on the target
    /// device.
    completed_at: ?i64 = null,

    /// The date and time at which the command execution was created for the target
    /// device.
    created_at: ?i64 = null,

    /// The unique identifier of the command execution.
    execution_id: ?[]const u8 = null,

    /// The date and time at which the command started executing on the target
    /// device.
    started_at: ?i64 = null,

    /// The status of the command executions.
    status: ?CommandExecutionStatus = null,

    /// The Amazon Resource Name (ARN) of the target device for which the command is
    /// being
    /// executed.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .command_arn = "commandArn",
        .completed_at = "completedAt",
        .created_at = "createdAt",
        .execution_id = "executionId",
        .started_at = "startedAt",
        .status = "status",
        .target_arn = "targetArn",
    };
};
