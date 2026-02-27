/// Summary information about a stream session.
pub const StreamSessionSummary = struct {
    /// Time when the channel went offline. This is an ISO 8601 timestamp; *note
    /// that
    /// this is returned as a string*. For live streams, this is `NULL`.
    end_time: ?i64,

    /// If `true`, this stream encountered a quota breach or failure.
    has_error_event: bool = false,

    /// Time when the channel went live. This is an ISO 8601 timestamp; *note that
    /// this
    /// is returned as a string*.
    start_time: ?i64,

    /// Unique identifier for a live or previously live stream in the specified
    /// channel.
    stream_id: ?[]const u8,

    pub const json_field_names = .{
        .end_time = "endTime",
        .has_error_event = "hasErrorEvent",
        .start_time = "startTime",
        .stream_id = "streamId",
    };
};
