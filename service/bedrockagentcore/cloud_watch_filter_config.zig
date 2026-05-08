const SessionFilterConfig = @import("session_filter_config.zig").SessionFilterConfig;

/// Filter configuration for narrowing down CloudWatch Logs sessions for
/// evaluation.
pub const CloudWatchFilterConfig = struct {
    /// A list of specific session IDs to evaluate. If specified, only these
    /// sessions are included in the evaluation.
    session_ids: ?[]const []const u8 = null,

    /// The time range filter for selecting sessions to evaluate.
    time_range: ?SessionFilterConfig = null,

    pub const json_field_names = .{
        .session_ids = "sessionIds",
        .time_range = "timeRange",
    };
};
