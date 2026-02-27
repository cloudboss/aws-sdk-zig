/// Provides the details of the `WorkflowExecutionFailed` event.
pub const WorkflowExecutionFailedEventAttributes = struct {
    /// The ID of the `DecisionTaskCompleted` event corresponding to the decision
    /// task that resulted in the
    /// `FailWorkflowExecution` decision to fail this execution. This information
    /// can be useful for diagnosing problems by tracing back the chain of
    /// events leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    /// The details of the failure.
    details: ?[]const u8,

    /// The descriptive reason provided for the failure.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .details = "details",
        .reason = "reason",
    };
};
