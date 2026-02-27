/// Provides the details of the `LambdaFunctionScheduled` event. It isn't set
/// for other event types.
pub const LambdaFunctionScheduledEventAttributes = struct {
    /// Data attached to the event that the decider can use in subsequent workflow
    /// tasks. This
    /// data isn't sent to the Lambda task.
    control: ?[]const u8,

    /// The ID of the `LambdaFunctionCompleted` event corresponding to the decision
    /// that resulted in scheduling this activity task. To help diagnose issues, use
    /// this information to trace back the chain of events leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    /// The unique ID of the Lambda task.
    id: []const u8,

    /// The input provided to the Lambda task.
    input: ?[]const u8,

    /// The name of the Lambda function.
    name: []const u8,

    /// The maximum amount of time a worker can take to process the Lambda task.
    start_to_close_timeout: ?[]const u8,

    pub const json_field_names = .{
        .control = "control",
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .id = "id",
        .input = "input",
        .name = "name",
        .start_to_close_timeout = "startToCloseTimeout",
    };
};
