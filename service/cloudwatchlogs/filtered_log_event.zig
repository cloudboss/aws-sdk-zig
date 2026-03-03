/// Represents a matched event.
pub const FilteredLogEvent = struct {
    /// The ID of the event.
    event_id: ?[]const u8 = null,

    /// The time the event was ingested, expressed as the number of milliseconds
    /// after
    /// `Jan 1, 1970 00:00:00 UTC`.
    ingestion_time: ?i64 = null,

    /// The name of the log stream to which this event belongs.
    log_stream_name: ?[]const u8 = null,

    /// The data contained in the log event.
    message: ?[]const u8 = null,

    /// The time the event occurred, expressed as the number of milliseconds after
    /// `Jan 1,
    /// 1970 00:00:00 UTC`.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .event_id = "eventId",
        .ingestion_time = "ingestionTime",
        .log_stream_name = "logStreamName",
        .message = "message",
        .timestamp = "timestamp",
    };
};
