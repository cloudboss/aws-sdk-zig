const WorkflowExecution = @import("workflow_execution.zig").WorkflowExecution;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Provide details of the `ChildWorkflowExecutionCanceled` event.
pub const ChildWorkflowExecutionCanceledEventAttributes = struct {
    /// Details of the cancellation (if provided).
    details: ?[]const u8,

    /// The ID of the `StartChildWorkflowExecutionInitiated` event corresponding to
    /// the
    /// `StartChildWorkflowExecution`
    /// Decision to start this child workflow execution.
    /// This information can be useful for diagnosing problems by tracing back the
    /// chain of
    /// events leading up to this event.
    initiated_event_id: i64 = 0,

    /// The ID of the `ChildWorkflowExecutionStarted` event recorded when this child
    /// workflow execution was
    /// started. This information can be useful for diagnosing problems by tracing
    /// back the chain of
    /// events leading up to this event.
    started_event_id: i64 = 0,

    /// The child workflow execution that was canceled.
    workflow_execution: WorkflowExecution,

    /// The type of the child workflow execution.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .details = "details",
        .initiated_event_id = "initiatedEventId",
        .started_event_id = "startedEventId",
        .workflow_execution = "workflowExecution",
        .workflow_type = "workflowType",
    };
};
