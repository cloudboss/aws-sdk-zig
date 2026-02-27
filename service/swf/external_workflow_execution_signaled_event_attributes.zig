const WorkflowExecution = @import("workflow_execution.zig").WorkflowExecution;

/// Provides the details of the `ExternalWorkflowExecutionSignaled` event.
pub const ExternalWorkflowExecutionSignaledEventAttributes = struct {
    /// The ID of the `SignalExternalWorkflowExecutionInitiated` event corresponding
    /// to the
    /// `SignalExternalWorkflowExecution` decision to request this signal. This
    /// information can be useful for diagnosing problems by tracing back the chain
    /// of
    /// events leading up to this event.
    initiated_event_id: i64 = 0,

    /// The external workflow execution that the signal was delivered to.
    workflow_execution: WorkflowExecution,

    pub const json_field_names = .{
        .initiated_event_id = "initiatedEventId",
        .workflow_execution = "workflowExecution",
    };
};
