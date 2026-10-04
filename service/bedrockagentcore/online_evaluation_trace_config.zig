/// Contains the configuration for reusing agent traces from an online
/// evaluation configuration for recommendation analysis. Because online
/// evaluation is a continuous stream, a time range specifies which evaluated
/// sessions the recommendation includes.
pub const OnlineEvaluationTraceConfig = struct {
    /// The end time of the time range. Only sessions evaluated before this
    /// timestamp are included.
    end_time: i64,

    /// The ARN of the online evaluation configuration to reuse sessions from.
    online_evaluation_config_arn: []const u8,

    /// The start time of the time range. Only sessions evaluated at or after this
    /// timestamp are included.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .online_evaluation_config_arn = "onlineEvaluationConfigArn",
        .start_time = "startTime",
    };
};
