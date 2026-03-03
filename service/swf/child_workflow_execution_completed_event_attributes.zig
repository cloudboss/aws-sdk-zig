const WorkflowExecution = @import("workflow_execution.zig").WorkflowExecution;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Provides the details of the `ChildWorkflowExecutionCompleted` event.
pub const ChildWorkflowExecutionCompletedEventAttributes = struct {
    /// The ID of the `StartChildWorkflowExecutionInitiated` event corresponding to
    /// the `StartChildWorkflowExecution`
    /// Decision to start this child workflow execution. This information can be
    /// useful for diagnosing problems by tracing back the chain of events leading
    /// up to this event.
    initiated_event_id: i64 = 0,

    /// The result of the child workflow execution.
    result: ?[]const u8 = null,

    /// The ID of the `ChildWorkflowExecutionStarted` event recorded when this child
    /// workflow execution was
    /// started. This information can be useful for diagnosing problems by tracing
    /// back the chain of
    /// events leading up to this event.
    started_event_id: i64 = 0,

    /// The child workflow execution that was completed.
    workflow_execution: WorkflowExecution,

    /// The type of the child workflow execution.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .initiated_event_id = "initiatedEventId",
        .result = "result",
        .started_event_id = "startedEventId",
        .workflow_execution = "workflowExecution",
        .workflow_type = "workflowType",
    };
};
