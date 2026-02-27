/// A time limit for how long the monitoring job is allowed to run before
/// stopping.
pub const MonitoringStoppingCondition = struct {
    /// The maximum runtime allowed in seconds.
    ///
    /// The `MaxRuntimeInSeconds` cannot exceed the frequency of the job. For data
    /// quality and model explainability, this can be up to 3600 seconds for an
    /// hourly schedule. For model bias and model quality hourly schedules, this can
    /// be up to 1800 seconds.
    max_runtime_in_seconds: i32,

    pub const json_field_names = .{
        .max_runtime_in_seconds = "MaxRuntimeInSeconds",
    };
};
