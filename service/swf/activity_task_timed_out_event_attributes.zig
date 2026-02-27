const ActivityTaskTimeoutType = @import("activity_task_timeout_type.zig").ActivityTaskTimeoutType;

/// Provides the details of the `ActivityTaskTimedOut` event.
pub const ActivityTaskTimedOutEventAttributes = struct {
    /// Contains the content of the `details` parameter for the last call made by
    /// the activity to
    /// `RecordActivityTaskHeartbeat`.
    details: ?[]const u8,

    /// The ID of the `ActivityTaskScheduled` event that was recorded when this
    /// activity task was scheduled. This information can be useful for diagnosing
    /// problems by tracing back the chain of events leading up to this event.
    scheduled_event_id: i64 = 0,

    /// The ID of the `ActivityTaskStarted` event recorded when this activity task
    /// was started. This
    /// information can be useful for diagnosing problems by tracing back the chain
    /// of events leading up to this
    /// event.
    started_event_id: i64 = 0,

    /// The type of the timeout that caused this event.
    timeout_type: ActivityTaskTimeoutType,

    pub const json_field_names = .{
        .details = "details",
        .scheduled_event_id = "scheduledEventId",
        .started_event_id = "startedEventId",
        .timeout_type = "timeoutType",
    };
};
