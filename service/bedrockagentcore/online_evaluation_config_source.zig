const SessionFilterConfig = @import("session_filter_config.zig").SessionFilterConfig;

/// A reference to an existing online evaluation configuration to use as the
/// data source for batch evaluation.
pub const OnlineEvaluationConfigSource = struct {
    /// The Amazon Resource Name (ARN) of the online evaluation configuration to use
    /// as the session source.
    online_evaluation_config_arn: []const u8,

    /// Optional session filter configuration to narrow down which sessions from the
    /// online evaluation configuration to include.
    time_range: ?SessionFilterConfig = null,

    pub const json_field_names = .{
        .online_evaluation_config_arn = "onlineEvaluationConfigArn",
        .time_range = "timeRange",
    };
};
