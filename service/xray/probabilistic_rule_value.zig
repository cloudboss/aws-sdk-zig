/// The indexing rule configuration for probabilistic sampling.
pub const ProbabilisticRuleValue = struct {
    /// Applied sampling percentage of traceIds.
    actual_sampling_percentage: ?f64,

    /// Configured sampling percentage of traceIds. Note that sampling can be
    /// subject to limits to ensure completeness of data.
    desired_sampling_percentage: f64,

    pub const json_field_names = .{
        .actual_sampling_percentage = "ActualSamplingPercentage",
        .desired_sampling_percentage = "DesiredSamplingPercentage",
    };
};
