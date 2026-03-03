/// Provides the details of the `WorkflowExecutionCanceled` event.
pub const WorkflowExecutionCanceledEventAttributes = struct {
    /// The ID of the `DecisionTaskCompleted` event corresponding to the decision
    /// task that resulted in the
    /// `CancelWorkflowExecution` decision for this cancellation request. This
    /// information can be useful for diagnosing problems by tracing back the chain
    /// of
    /// events leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    /// The details of the cancellation.
    details: ?[]const u8 = null,

    pub const json_field_names = .{
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .details = "details",
    };
};
