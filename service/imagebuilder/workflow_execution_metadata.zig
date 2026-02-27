const WorkflowExecutionStatus = @import("workflow_execution_status.zig").WorkflowExecutionStatus;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Metadata that includes details and status from this runtime instance of the
/// workflow.
pub const WorkflowExecutionMetadata = struct {
    /// The timestamp when this runtime instance of the workflow finished.
    end_time: ?[]const u8,

    /// The runtime output message from the workflow, if applicable.
    message: ?[]const u8,

    /// The name of the test group that included the test workflow resource at
    /// runtime.
    parallel_group: ?[]const u8,

    /// Indicates retry status for this runtime instance of the workflow.
    retried: ?bool,

    /// The timestamp when the runtime instance of this workflow started.
    start_time: ?[]const u8,

    /// The current runtime status for this workflow.
    status: ?WorkflowExecutionStatus,

    /// The total number of steps in the workflow. This should equal the sum of the
    /// step
    /// counts for steps that succeeded, were skipped, and failed.
    total_step_count: i32 = 0,

    /// A runtime count for the number of steps in the workflow that failed.
    total_steps_failed: i32 = 0,

    /// A runtime count for the number of steps in the workflow that were skipped.
    total_steps_skipped: i32 = 0,

    /// A runtime count for the number of steps in the workflow that ran
    /// successfully.
    total_steps_succeeded: i32 = 0,

    /// Indicates what type of workflow that Image Builder ran for this runtime
    /// instance of the workflow.
    type: ?WorkflowType,

    /// The Amazon Resource Name (ARN) of the workflow resource build version that
    /// ran.
    workflow_build_version_arn: ?[]const u8,

    /// Unique identifier that Image Builder assigns to keep track of runtime
    /// resources each time it runs a
    /// workflow.
    workflow_execution_id: ?[]const u8,

    pub const json_field_names = .{
        .end_time = "endTime",
        .message = "message",
        .parallel_group = "parallelGroup",
        .retried = "retried",
        .start_time = "startTime",
        .status = "status",
        .total_step_count = "totalStepCount",
        .total_steps_failed = "totalStepsFailed",
        .total_steps_skipped = "totalStepsSkipped",
        .total_steps_succeeded = "totalStepsSucceeded",
        .type = "type",
        .workflow_build_version_arn = "workflowBuildVersionArn",
        .workflow_execution_id = "workflowExecutionId",
    };
};
