const CloseStatus = @import("close_status.zig").CloseStatus;
const WorkflowExecution = @import("workflow_execution.zig").WorkflowExecution;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Contains information about a workflow execution.
pub const WorkflowExecutionInfo = struct {
    /// Set to true if a cancellation is requested for this workflow execution.
    cancel_requested: bool = false,

    /// If the execution status is closed then this specifies how the execution was
    /// closed:
    ///
    /// * `COMPLETED` – the execution was successfully completed.
    ///
    /// * `CANCELED` – the execution was canceled.Cancellation allows the
    ///   implementation to gracefully clean
    /// up before the execution is closed.
    ///
    /// * `TERMINATED` – the execution was force terminated.
    ///
    /// * `FAILED` – the execution failed to complete.
    ///
    /// * `TIMED_OUT` – the execution did not complete in the alloted time and was
    ///   automatically timed
    /// out.
    ///
    /// * `CONTINUED_AS_NEW` – the execution is logically continued. This means the
    ///   current execution was
    /// completed and a new execution was started to carry on the workflow.
    close_status: ?CloseStatus = null,

    /// The time when the workflow execution was closed. Set only if the execution
    /// status is CLOSED.
    close_timestamp: ?i64 = null,

    /// The workflow execution this information is about.
    execution: WorkflowExecution,

    /// The current status of the execution.
    execution_status: ExecutionStatus,

    /// If this workflow execution is a child of another execution then contains the
    /// workflow execution that started this execution.
    parent: ?WorkflowExecution = null,

    /// The time when the execution was started.
    start_timestamp: i64,

    /// The list of tags associated with the workflow execution. Tags can be used to
    /// identify and list workflow executions of interest through the visibility
    /// APIs. A workflow execution can have a maximum of 5 tags.
    tag_list: ?[]const []const u8 = null,

    /// The type of the workflow execution.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .cancel_requested = "cancelRequested",
        .close_status = "closeStatus",
        .close_timestamp = "closeTimestamp",
        .execution = "execution",
        .execution_status = "executionStatus",
        .parent = "parent",
        .start_timestamp = "startTimestamp",
        .tag_list = "tagList",
        .workflow_type = "workflowType",
    };
};
