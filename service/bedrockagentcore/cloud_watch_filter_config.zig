const SessionTraceIds = @import("session_trace_ids.zig").SessionTraceIds;
const SessionFilterConfig = @import("session_filter_config.zig").SessionFilterConfig;

/// Filter configuration for narrowing down CloudWatch Logs sessions for
/// evaluation.
pub const CloudWatchFilterConfig = struct {
    /// A list of specific session IDs to evaluate. If specified, only these
    /// sessions are included in the evaluation.
    session_ids: ?[]const []const u8 = null,

    /// A list of session and trace ID pairs that restrict evaluation to specific
    /// traces within a session. If specified, only the listed traces are evaluated
    /// instead of the entire session.
    session_trace_ids: ?[]const SessionTraceIds = null,

    /// The time range filter for selecting sessions to evaluate.
    time_range: ?SessionFilterConfig = null,

    pub const json_field_names = .{
        .session_ids = "sessionIds",
        .session_trace_ids = "sessionTraceIds",
        .time_range = "timeRange",
    };
};
