const StreamSessionSummary = @import("stream_session_summary.zig").StreamSessionSummary;

pub const ListStreamSessionsResponse = struct {
    /// If there are more streams than `maxResults`, use `nextToken` in the request
    /// to get the next set.
    next_token: ?[]const u8 = null,

    /// List of stream sessions.
    stream_sessions: []const StreamSessionSummary,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .stream_sessions = "streamSessions",
    };
};
