const ChildPolicy = @import("child_policy.zig").ChildPolicy;
const WorkflowExecutionTimeoutType = @import("workflow_execution_timeout_type.zig").WorkflowExecutionTimeoutType;

/// Provides the details of the `WorkflowExecutionTimedOut` event.
pub const WorkflowExecutionTimedOutEventAttributes = struct {
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

    /// The type of timeout that caused this event.
    timeout_type: WorkflowExecutionTimeoutType,

    pub const json_field_names = .{
        .child_policy = "childPolicy",
        .timeout_type = "timeoutType",
    };
};
