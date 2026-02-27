/// Provides the details of the `LambdaFunctionCompleted` event. It isn't set
/// for other event types.
pub const LambdaFunctionCompletedEventAttributes = struct {
    /// The results of the Lambda task.
    result: ?[]const u8,

    /// The ID of the `LambdaFunctionScheduled` event that was recorded when this
    /// Lambda task was scheduled. To help diagnose issues, use this information to
    /// trace back the chain of events leading up to this event.
    scheduled_event_id: i64 = 0,

    /// The ID of the `LambdaFunctionStarted` event recorded when this activity task
    /// started. To help diagnose issues, use this information to trace back the
    /// chain of events leading up to this event.
    started_event_id: i64 = 0,

    pub const json_field_names = .{
        .result = "result",
        .scheduled_event_id = "scheduledEventId",
        .started_event_id = "startedEventId",
    };
};
