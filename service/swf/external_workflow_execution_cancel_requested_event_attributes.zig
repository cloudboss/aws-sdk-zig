const WorkflowExecution = @import("workflow_execution.zig").WorkflowExecution;

/// Provides the details of the `ExternalWorkflowExecutionCancelRequested`
/// event.
pub const ExternalWorkflowExecutionCancelRequestedEventAttributes = struct {
    /// The ID of the `RequestCancelExternalWorkflowExecutionInitiated` event
    /// corresponding to the
    /// `RequestCancelExternalWorkflowExecution` decision to cancel this external
    /// workflow execution. This
    /// information can be useful for diagnosing problems by tracing back the chain
    /// of events leading up to this
    /// event.
    initiated_event_id: i64 = 0,

    /// The external workflow execution to which the cancellation request was
    /// delivered.
    workflow_execution: WorkflowExecution,

    pub const json_field_names = .{
        .initiated_event_id = "initiatedEventId",
        .workflow_execution = "workflowExecution",
    };
};
