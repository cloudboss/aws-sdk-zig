/// Provides the details of the `LambdaFunctionStarted` event. It isn't set for
/// other event types.
pub const LambdaFunctionStartedEventAttributes = struct {
    /// The ID of the `LambdaFunctionScheduled` event that was recorded when this
    /// activity task was scheduled. To help diagnose issues, use this information
    /// to trace back the chain of events leading up to this event.
    scheduled_event_id: i64 = 0,

    pub const json_field_names = .{
        .scheduled_event_id = "scheduledEventId",
    };
};
