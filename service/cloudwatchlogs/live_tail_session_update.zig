const LiveTailSessionMetadata = @import("live_tail_session_metadata.zig").LiveTailSessionMetadata;
const LiveTailSessionLogEvent = @import("live_tail_session_log_event.zig").LiveTailSessionLogEvent;

/// This object contains the log events and metadata for a Live Tail session.
pub const LiveTailSessionUpdate = struct {
    /// This object contains the session metadata for a Live Tail session.
    session_metadata: ?LiveTailSessionMetadata,

    /// An array, where each member of the array includes the information for one
    /// log event in the
    /// Live Tail session.
    ///
    /// A `sessionResults` array can include as many as 500 log events. If the
    /// number
    /// of log events matching the request exceeds 500 per second, the log events
    /// are sampled down to
    /// 500 log events to be included in each `sessionUpdate` structure.
    session_results: ?[]const LiveTailSessionLogEvent,

    pub const json_field_names = .{
        .session_metadata = "sessionMetadata",
        .session_results = "sessionResults",
    };
};
