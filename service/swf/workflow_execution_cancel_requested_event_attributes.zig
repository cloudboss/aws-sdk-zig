const WorkflowExecutionCancelRequestedCause = @import("workflow_execution_cancel_requested_cause.zig").WorkflowExecutionCancelRequestedCause;
const WorkflowExecution = @import("workflow_execution.zig").WorkflowExecution;

/// Provides the details of the `WorkflowExecutionCancelRequested` event.
pub const WorkflowExecutionCancelRequestedEventAttributes = struct {
    /// If set, indicates that the request to cancel the workflow execution was
    /// automatically generated, and specifies the cause. This happens if the parent
    /// workflow execution times out or is terminated, and the child policy is set
    /// to cancel child executions.
    cause: ?WorkflowExecutionCancelRequestedCause = null,

    /// The ID of the `RequestCancelExternalWorkflowExecutionInitiated` event
    /// corresponding to the
    /// `RequestCancelExternalWorkflowExecution` decision to cancel this workflow
    /// execution.The source event
    /// with this ID can be found in the history of the source workflow execution.
    /// This information can be useful for diagnosing problems by tracing back the
    /// chain of
    /// events leading up to this event.
    external_initiated_event_id: i64 = 0,

    /// The external workflow execution for which the cancellation was requested.
    external_workflow_execution: ?WorkflowExecution = null,

    pub const json_field_names = .{
        .cause = "cause",
        .external_initiated_event_id = "externalInitiatedEventId",
        .external_workflow_execution = "externalWorkflowExecution",
    };
};
