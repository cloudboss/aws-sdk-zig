/// This structure contains the information for one sample log event that is
/// associated with
/// an anomaly found by a log anomaly detector.
pub const LogEvent = struct {
    /// The message content of the log event.
    message: ?[]const u8 = null,

    /// The time stamp of the log event.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .message = "message",
        .timestamp = "timestamp",
    };
};
