/// This object contains the information for one log event returned in a Live
/// Tail
/// stream.
pub const LiveTailSessionLogEvent = struct {
    /// The timestamp specifying when this log event was ingested into the log
    /// group.
    ingestion_time: ?i64 = null,

    /// The name or ARN of the log group that ingested this log event.
    log_group_identifier: ?[]const u8 = null,

    /// The name of the log stream that ingested this log event.
    log_stream_name: ?[]const u8 = null,

    /// The log event message text.
    message: ?[]const u8 = null,

    /// The timestamp specifying when this log event was created.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .ingestion_time = "ingestionTime",
        .log_group_identifier = "logGroupIdentifier",
        .log_stream_name = "logStreamName",
        .message = "message",
        .timestamp = "timestamp",
    };
};
