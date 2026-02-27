/// Update to the indexing rule configuration for probabilistic sampling.
pub const ProbabilisticRuleValueUpdate = struct {
    /// Configured sampling percentage of traceIds. Note that sampling can be
    /// subject to limits to ensure completeness of data.
    desired_sampling_percentage: f64,

    pub const json_field_names = .{
        .desired_sampling_percentage = "DesiredSamplingPercentage",
    };
};
