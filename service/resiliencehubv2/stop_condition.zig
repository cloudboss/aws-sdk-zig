const StopConditionSource = @import("stop_condition_source.zig").StopConditionSource;

/// A CloudWatch alarm that automatically stops a test run if it breaches its
/// threshold.
pub const StopCondition = struct {
    /// The source of the stop condition.
    source: StopConditionSource,

    /// The value of the stop condition, such as the ARN of the CloudWatch alarm.
    value: []const u8,

    pub const json_field_names = .{
        .source = "source",
        .value = "value",
    };
};
