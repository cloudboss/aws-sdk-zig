const DecisionTaskTimeoutType = @import("decision_task_timeout_type.zig").DecisionTaskTimeoutType;

/// Provides the details of the `DecisionTaskTimedOut` event.
pub const DecisionTaskTimedOutEventAttributes = struct {
    /// The ID of the `DecisionTaskScheduled` event that was recorded when this
    /// decision task was scheduled.
    /// This information can be useful for diagnosing problems by tracing back the
    /// chain of
    /// events leading up to this event.
    scheduled_event_id: i64 = 0,

    /// The ID of the `DecisionTaskStarted` event recorded when this decision task
    /// was started. This
    /// information can be useful for diagnosing problems by tracing back the chain
    /// of events leading up to this
    /// event.
    started_event_id: i64 = 0,

    /// The type of timeout that expired before the decision task could be
    /// completed.
    timeout_type: DecisionTaskTimeoutType,

    pub const json_field_names = .{
        .scheduled_event_id = "scheduledEventId",
        .started_event_id = "startedEventId",
        .timeout_type = "timeoutType",
    };
};
