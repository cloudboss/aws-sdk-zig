/// Provides the details of the `ActivityTaskFailed` event.
pub const ActivityTaskFailedEventAttributes = struct {
    /// The details of the failure.
    details: ?[]const u8,

    /// The reason provided for the failure.
    reason: ?[]const u8,

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

    pub const json_field_names = .{
        .details = "details",
        .reason = "reason",
        .scheduled_event_id = "scheduledEventId",
        .started_event_id = "startedEventId",
    };
};
