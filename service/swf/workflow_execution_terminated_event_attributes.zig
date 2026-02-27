const WorkflowExecutionTerminatedCause = @import("workflow_execution_terminated_cause.zig").WorkflowExecutionTerminatedCause;
const ChildPolicy = @import("child_policy.zig").ChildPolicy;

/// Provides the details of the `WorkflowExecutionTerminated` event.
pub const WorkflowExecutionTerminatedEventAttributes = struct {
    /// If set, indicates that the workflow execution was automatically terminated,
    /// and specifies the cause. This happens if the parent workflow execution times
    /// out or is terminated and the child policy is set to terminate child
    /// executions.
    cause: ?WorkflowExecutionTerminatedCause,

    /// The policy used for the child workflow executions of this workflow
    /// execution.
    ///
    /// The supported child policies are:
    ///
    /// * `TERMINATE` – The child executions are terminated.
    ///
    /// * `REQUEST_CANCEL` – A request to cancel is attempted for each child
    /// execution by recording a `WorkflowExecutionCancelRequested` event in its
    /// history. It is up to the decider
    /// to take appropriate actions when it receives an execution history with this
    /// event.
    ///
    /// * `ABANDON` – No action is taken. The child executions continue to run.
    child_policy: ChildPolicy,

    /// The details provided for the termination.
    details: ?[]const u8,

    /// The reason provided for the termination.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .cause = "cause",
        .child_policy = "childPolicy",
        .details = "details",
        .reason = "reason",
    };
};
