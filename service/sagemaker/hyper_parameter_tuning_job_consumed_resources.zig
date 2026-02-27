/// The total resources consumed by your hyperparameter tuning job.
pub const HyperParameterTuningJobConsumedResources = struct {
    /// The wall clock runtime in seconds used by your hyperparameter tuning job.
    runtime_in_seconds: ?i32,

    pub const json_field_names = .{
        .runtime_in_seconds = "RuntimeInSeconds",
    };
};
