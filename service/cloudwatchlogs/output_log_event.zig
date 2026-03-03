/// Represents a log event.
pub const OutputLogEvent = struct {
    /// The time the event was ingested, expressed as the number of milliseconds
    /// after
    /// `Jan 1, 1970 00:00:00 UTC`.
    ingestion_time: ?i64 = null,

    /// The data contained in the log event.
    message: ?[]const u8 = null,

    /// The time the event occurred, expressed as the number of milliseconds after
    /// `Jan 1,
    /// 1970 00:00:00 UTC`.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .ingestion_time = "ingestionTime",
        .message = "message",
        .timestamp = "timestamp",
    };
};
