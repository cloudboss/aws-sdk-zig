/// Specifies a stop condition for an experiment. You can define a stop
/// condition as a CloudWatch alarm.
pub const UpdateExperimentTemplateStopConditionInput = struct {
    /// The source for the stop condition. Specify `aws:cloudwatch:alarm` if the
    /// stop
    /// condition is defined by a CloudWatch alarm. Specify `none` if there is no
    /// stop
    /// condition.
    source: []const u8,

    /// The Amazon Resource Name (ARN) of the CloudWatch alarm.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .source = "source",
        .value = "value",
    };
};
