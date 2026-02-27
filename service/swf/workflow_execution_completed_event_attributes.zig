/// Provides the details of the `WorkflowExecutionCompleted` event.
pub const WorkflowExecutionCompletedEventAttributes = struct {
    /// The ID of the `DecisionTaskCompleted` event corresponding to the decision
    /// task that resulted in the
    /// `CompleteWorkflowExecution` decision to complete this execution. This
    /// information can be useful for diagnosing problems by tracing back the chain
    /// of
    /// events leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    /// The result produced by the workflow execution upon successful completion.
    result: ?[]const u8,

    pub const json_field_names = .{
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .result = "result",
    };
};
