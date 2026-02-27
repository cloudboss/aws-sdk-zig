/// The configuration that controls what percentage of agent traces are sampled
/// for evaluation to manage evaluation volume and costs.
pub const SamplingConfig = struct {
    /// The percentage of agent traces to sample for evaluation, ranging from 0.01%
    /// to 100%.
    sampling_percentage: f64,

    pub const json_field_names = .{
        .sampling_percentage = "samplingPercentage",
    };
};
