/// Represents a log stream, which is a sequence of log events from a single
/// emitter of
/// logs.
pub const LogStream = struct {
    /// The Amazon Resource Name (ARN) of the log stream.
    arn: ?[]const u8,

    /// The creation time of the stream, expressed as the number of milliseconds
    /// after
    /// `Jan 1, 1970 00:00:00 UTC`.
    creation_time: ?i64,

    /// The time of the first event, expressed as the number of milliseconds after
    /// `Jan 1,
    /// 1970 00:00:00 UTC`.
    first_event_timestamp: ?i64,

    /// The time of the most recent log event in the log stream in CloudWatch Logs.
    /// This number
    /// is expressed as the number of milliseconds after `Jan 1, 1970 00:00:00 UTC`.
    /// The
    /// `lastEventTime` value updates on an eventual consistency basis. It typically
    /// updates in less than an hour from ingestion, but in rare situations might
    /// take
    /// longer.
    last_event_timestamp: ?i64,

    /// The ingestion time, expressed as the number of milliseconds after `Jan 1,
    /// 1970
    /// 00:00:00 UTC` The `lastIngestionTime` value updates on an eventual
    /// consistency basis. It typically updates in less than an hour after
    /// ingestion, but in rare
    /// situations might take longer.
    last_ingestion_time: ?i64,

    /// The name of the log stream.
    log_stream_name: ?[]const u8,

    /// The number of bytes stored.
    ///
    /// **Important:** As of June 17, 2019, this parameter is no
    /// longer supported for log streams, and is always reported as zero. This
    /// change applies only to
    /// log streams. The `storedBytes` parameter for log groups is not affected.
    stored_bytes: ?i64,

    /// The sequence token.
    ///
    /// The sequence token is now ignored in `PutLogEvents` actions.
    /// `PutLogEvents` actions are always accepted regardless of receiving an
    /// invalid
    /// sequence token. You don't need to obtain `uploadSequenceToken` to use a
    /// `PutLogEvents` action.
    upload_sequence_token: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .first_event_timestamp = "firstEventTimestamp",
        .last_event_timestamp = "lastEventTimestamp",
        .last_ingestion_time = "lastIngestionTime",
        .log_stream_name = "logStreamName",
        .stored_bytes = "storedBytes",
        .upload_sequence_token = "uploadSequenceToken",
    };
};
