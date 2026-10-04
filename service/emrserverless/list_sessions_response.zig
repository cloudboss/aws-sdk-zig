const SessionSummary = @import("session_summary.zig").SessionSummary;

pub const ListSessionsResponse = struct {
    /// The output displays the token for the next set of session results. This is
    /// required for pagination and is available as a response of the previous
    /// request.
    next_token: ?[]const u8 = null,

    /// The output lists information about the specified sessions.
    sessions: []const SessionSummary,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .sessions = "sessions",
    };
};
