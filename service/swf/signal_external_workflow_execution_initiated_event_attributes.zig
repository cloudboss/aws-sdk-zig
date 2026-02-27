/// Provides the details of the `SignalExternalWorkflowExecutionInitiated`
/// event.
pub const SignalExternalWorkflowExecutionInitiatedEventAttributes = struct {
    /// Data attached to the event that can be used by the decider in subsequent
    /// decision tasks.
    control: ?[]const u8,

    /// The ID of the `DecisionTaskCompleted` event corresponding to the decision
    /// task that resulted in the
    /// `SignalExternalWorkflowExecution` decision for this signal. This information
    /// can be useful for diagnosing problems by tracing back the chain of
    /// events leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    /// The input provided to the signal.
    input: ?[]const u8,

    /// The `runId` of the external workflow execution to send the signal to.
    run_id: ?[]const u8,

    /// The name of the signal.
    signal_name: []const u8,

    /// The `workflowId` of the external workflow execution.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .control = "control",
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .input = "input",
        .run_id = "runId",
        .signal_name = "signalName",
        .workflow_id = "workflowId",
    };
};
