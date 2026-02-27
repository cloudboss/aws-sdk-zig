const LiveTailSessionStart = @import("live_tail_session_start.zig").LiveTailSessionStart;
const SessionStreamingException = @import("session_streaming_exception.zig").SessionStreamingException;
const SessionTimeoutException = @import("session_timeout_exception.zig").SessionTimeoutException;
const LiveTailSessionUpdate = @import("live_tail_session_update.zig").LiveTailSessionUpdate;

/// This object includes the stream returned by your
/// [StartLiveTail](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_StartLiveTail.html)
/// request.
pub const StartLiveTailResponseStream = union(enum) {
    /// This object contains information about this Live Tail session, including the
    /// log groups
    /// included and the log stream filters, if any.
    session_start: ?LiveTailSessionStart,
    /// This exception is returned if an unknown error occurs.
    session_streaming_exception: ?SessionStreamingException,
    /// This exception is returned in the stream when the Live Tail session times
    /// out. Live Tail
    /// sessions time out after three hours.
    session_timeout_exception: ?SessionTimeoutException,
    /// This object contains the log events and session metadata.
    session_update: ?LiveTailSessionUpdate,

    pub const json_field_names = .{
        .session_start = "sessionStart",
        .session_streaming_exception = "SessionStreamingException",
        .session_timeout_exception = "SessionTimeoutException",
        .session_update = "sessionUpdate",
    };
};
