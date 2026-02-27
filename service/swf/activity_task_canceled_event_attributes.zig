/// Provides the details of the `ActivityTaskCanceled` event.
pub const ActivityTaskCanceledEventAttributes = struct {
    /// Details of the cancellation.
    details: ?[]const u8,

    /// If set, contains the ID of the last `ActivityTaskCancelRequested` event
    /// recorded for this activity task. This information can be useful for
    /// diagnosing problems by tracing back the chain of events leading up to this
    /// event.
    latest_cancel_requested_event_id: i64 = 0,

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
        .latest_cancel_requested_event_id = "latestCancelRequestedEventId",
        .scheduled_event_id = "scheduledEventId",
        .started_event_id = "startedEventId",
    };
};
