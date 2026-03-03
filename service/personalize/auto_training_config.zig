/// The automatic training configuration to use when `performAutoTraining` is
/// true.
pub const AutoTrainingConfig = struct {
    /// Specifies how often to automatically train new solution versions. Specify a
    /// rate expression in rate(*value*
    /// *unit*) format.
    /// For value, specify a number between 1 and 30. For unit, specify `day` or
    /// `days`.
    /// For example, to automatically create a new solution version every 5 days,
    /// specify `rate(5 days)`. The default is every 7 days.
    ///
    /// For more information about auto training, see [Creating and configuring a
    /// solution](https://docs.aws.amazon.com/personalize/latest/dg/customizing-solution-config.html).
    scheduling_expression: ?[]const u8 = null,

    pub const json_field_names = .{
        .scheduling_expression = "schedulingExpression",
    };
};
