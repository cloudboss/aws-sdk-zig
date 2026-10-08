const aws = @import("aws");

/// A single event in a test run's timeline.
pub const TestRunEvent = struct {
    /// Machine-parseable key-value attributes for the event.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The unique identifier of the event.
    event_id: []const u8,

    /// The type of the event, such as action_started, action_completed, or
    /// rto_recovery_detected.
    event_type: []const u8,

    /// A human-readable description of what happened.
    message: []const u8,

    /// The timestamp when the event occurred.
    timestamp: i64,

    pub const json_field_names = .{
        .attributes = "attributes",
        .event_id = "eventId",
        .event_type = "eventType",
        .message = "message",
        .timestamp = "timestamp",
    };
};
