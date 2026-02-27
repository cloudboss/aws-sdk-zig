/// Provides the details of the `LambdaFunctionFailed` event. It isn't set for
/// other event types.
pub const LambdaFunctionFailedEventAttributes = struct {
    /// The details of the failure.
    details: ?[]const u8,

    /// The reason provided for the failure.
    reason: ?[]const u8,

    /// The ID of the `LambdaFunctionScheduled` event that was recorded when this
    /// activity task was scheduled. To help diagnose issues, use this information
    /// to trace back the chain of events leading up to this event.
    scheduled_event_id: i64 = 0,

    /// The ID of the `LambdaFunctionStarted` event recorded when this activity task
    /// started. To help diagnose issues, use this information to trace back the
    /// chain of events leading up to this event.
    started_event_id: i64 = 0,

    pub const json_field_names = .{
        .details = "details",
        .reason = "reason",
        .scheduled_event_id = "scheduledEventId",
        .started_event_id = "startedEventId",
    };
};
