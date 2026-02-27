const WorkflowExecution = @import("workflow_execution.zig").WorkflowExecution;

/// Provides the details of the `WorkflowExecutionSignaled` event.
pub const WorkflowExecutionSignaledEventAttributes = struct {
    /// The ID of the `SignalExternalWorkflowExecutionInitiated` event corresponding
    /// to the
    /// `SignalExternalWorkflow` decision to signal this workflow execution.The
    /// source event with this ID can
    /// be found in the history of the source workflow execution. This information
    /// can be useful for diagnosing problems by tracing back the chain of
    /// events leading up to this event. This field is set only if
    /// the signal was initiated by another workflow execution.
    external_initiated_event_id: i64 = 0,

    /// The workflow execution that sent the signal. This is set only of the signal
    /// was sent by another workflow execution.
    external_workflow_execution: ?WorkflowExecution,

    /// The inputs provided with the signal. The decider can use the signal name and
    /// inputs to determine how to process the signal.
    input: ?[]const u8,

    /// The name of the signal received. The decider can use the signal name and
    /// inputs to determine how to the process the signal.
    signal_name: []const u8,

    pub const json_field_names = .{
        .external_initiated_event_id = "externalInitiatedEventId",
        .external_workflow_execution = "externalWorkflowExecution",
        .input = "input",
        .signal_name = "signalName",
    };
};
