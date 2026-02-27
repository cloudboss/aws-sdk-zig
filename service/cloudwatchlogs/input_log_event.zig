/// Represents a log event, which is a record of activity that was recorded by
/// the
/// application or resource being monitored.
pub const InputLogEvent = struct {
    /// The raw event message. Each log event can be no larger than 1 MB.
    message: []const u8,

    /// The time the event occurred, expressed as the number of milliseconds after
    /// `Jan 1,
    /// 1970 00:00:00 UTC`.
    timestamp: i64,

    pub const json_field_names = .{
        .message = "message",
        .timestamp = "timestamp",
    };
};
