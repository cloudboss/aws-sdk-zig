/// Describes a stop condition for an experiment template.
pub const ExperimentTemplateStopCondition = struct {
    /// The source for the stop condition.
    source: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the CloudWatch alarm, if applicable.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .source = "source",
        .value = "value",
    };
};
