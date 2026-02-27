/// Provides the details of the `TimerFired` event.
pub const TimerFiredEventAttributes = struct {
    /// The ID of the `TimerStarted` event that was recorded when this timer was
    /// started.
    /// This information can be useful for diagnosing problems by tracing back the
    /// chain of
    /// events leading up to this event.
    started_event_id: i64 = 0,

    /// The unique ID of the timer that fired.
    timer_id: []const u8,

    pub const json_field_names = .{
        .started_event_id = "startedEventId",
        .timer_id = "timerId",
    };
};
