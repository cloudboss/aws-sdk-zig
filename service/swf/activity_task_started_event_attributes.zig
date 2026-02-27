/// Provides the details of the `ActivityTaskStarted` event.
pub const ActivityTaskStartedEventAttributes = struct {
    /// Identity of the worker that was assigned this task. This aids diagnostics
    /// when problems arise. The form of this identity is user defined.
    identity: ?[]const u8,

    /// The ID of the `ActivityTaskScheduled` event that was recorded when this
    /// activity task was scheduled. This information can be useful for diagnosing
    /// problems by tracing back the chain of events leading up to this event.
    scheduled_event_id: i64 = 0,

    pub const json_field_names = .{
        .identity = "identity",
        .scheduled_event_id = "scheduledEventId",
    };
};
