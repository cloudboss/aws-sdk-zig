/// Specifies a stop condition for an experiment template.
pub const CreateExperimentTemplateStopConditionInput = struct {
    /// The source for the stop condition. Specify `aws:cloudwatch:alarm` if the
    /// stop
    /// condition is defined by a CloudWatch alarm. Specify `none` if there is no
    /// stop
    /// condition.
    source: []const u8,

    /// The Amazon Resource Name (ARN) of the CloudWatch alarm. This is required if
    /// the source is
    /// a CloudWatch alarm.
    value: ?[]const u8,

    pub const json_field_names = .{
        .source = "source",
        .value = "value",
    };
};
