const WorkflowStepExecutionRollbackStatus = @import("workflow_step_execution_rollback_status.zig").WorkflowStepExecutionRollbackStatus;
const WorkflowStepExecutionStatus = @import("workflow_step_execution_status.zig").WorkflowStepExecutionStatus;

/// Runtime details and status for the workflow step.
pub const WorkflowStepMetadata = struct {
    /// The step action name.
    action: ?[]const u8,

    /// Description of the workflow step.
    description: ?[]const u8,

    /// The timestamp when the workflow step finished.
    end_time: ?[]const u8,

    /// Input parameters that Image Builder provides for the workflow step.
    inputs: ?[]const u8,

    /// Detailed output message that the workflow step provides at runtime.
    message: ?[]const u8,

    /// The name of the workflow step.
    name: ?[]const u8,

    /// The file names that the workflow step created as output for this runtime
    /// instance of the workflow.
    outputs: ?[]const u8,

    /// Reports on the rollback status of the step, if applicable.
    rollback_status: ?WorkflowStepExecutionRollbackStatus,

    /// The timestamp when the workflow step started.
    start_time: ?[]const u8,

    /// Runtime status for the workflow step.
    status: ?WorkflowStepExecutionStatus,

    /// A unique identifier for the workflow step, assigned at runtime.
    step_execution_id: ?[]const u8,

    pub const json_field_names = .{
        .action = "action",
        .description = "description",
        .end_time = "endTime",
        .inputs = "inputs",
        .message = "message",
        .name = "name",
        .outputs = "outputs",
        .rollback_status = "rollbackStatus",
        .start_time = "startTime",
        .status = "status",
        .step_execution_id = "stepExecutionId",
    };
};
