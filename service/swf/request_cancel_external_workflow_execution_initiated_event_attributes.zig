/// Provides the details of the
/// `RequestCancelExternalWorkflowExecutionInitiated` event.
pub const RequestCancelExternalWorkflowExecutionInitiatedEventAttributes = struct {
    /// Data attached to the event that can be used by the decider in subsequent
    /// workflow tasks.
    control: ?[]const u8 = null,

    /// The ID of the `DecisionTaskCompleted` event corresponding to the decision
    /// task that resulted in the
    /// `RequestCancelExternalWorkflowExecution` decision for this cancellation
    /// request.
    /// This information can be useful for diagnosing problems by tracing back the
    /// chain of
    /// events leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    /// The `runId` of the external workflow execution to be canceled.
    run_id: ?[]const u8 = null,

    /// The `workflowId` of the external workflow execution to be canceled.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .control = "control",
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .run_id = "runId",
        .workflow_id = "workflowId",
    };
};
