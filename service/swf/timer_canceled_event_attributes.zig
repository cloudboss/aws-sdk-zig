/// Provides the details of the `TimerCanceled` event.
pub const TimerCanceledEventAttributes = struct {
    /// The ID of the `DecisionTaskCompleted` event corresponding to the decision
    /// task that resulted in the
    /// `CancelTimer` decision to cancel this timer. This information can be useful
    /// for diagnosing problems by tracing back the chain of
    /// events leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    /// The ID of the `TimerStarted` event that was recorded when this timer was
    /// started.
    /// This information can be useful for diagnosing problems by tracing back the
    /// chain of
    /// events leading up to this event.
    started_event_id: i64 = 0,

    /// The unique ID of the timer that was canceled.
    timer_id: []const u8,

    pub const json_field_names = .{
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .started_event_id = "startedEventId",
        .timer_id = "timerId",
    };
};
