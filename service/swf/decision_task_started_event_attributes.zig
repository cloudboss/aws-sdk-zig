/// Provides the details of the `DecisionTaskStarted` event.
pub const DecisionTaskStartedEventAttributes = struct {
    /// Identity of the decider making the request. This enables diagnostic tracing
    /// when problems arise. The form of this identity is user defined.
    identity: ?[]const u8,

    /// The ID of the `DecisionTaskScheduled` event that was recorded when this
    /// decision task was scheduled.
    /// This information can be useful for diagnosing problems by tracing back the
    /// chain of
    /// events leading up to this event.
    scheduled_event_id: i64 = 0,

    pub const json_field_names = .{
        .identity = "identity",
        .scheduled_event_id = "scheduledEventId",
    };
};
