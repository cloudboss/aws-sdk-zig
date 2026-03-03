/// Provides the details of the `TimerStarted` event.
pub const TimerStartedEventAttributes = struct {
    /// Data attached to the event that can be used by the decider in subsequent
    /// workflow tasks.
    control: ?[]const u8 = null,

    /// The ID of the `DecisionTaskCompleted` event corresponding to the decision
    /// task that resulted in the
    /// `StartTimer` decision for this activity task. This information can be useful
    /// for diagnosing problems by tracing back the chain of
    /// events leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    /// The duration of time after which the timer fires.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`.
    start_to_fire_timeout: []const u8,

    /// The unique ID of the timer that was started.
    timer_id: []const u8,

    pub const json_field_names = .{
        .control = "control",
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .start_to_fire_timeout = "startToFireTimeout",
        .timer_id = "timerId",
    };
};
