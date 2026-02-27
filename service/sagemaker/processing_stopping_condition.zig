/// Configures conditions under which the processing job should be stopped, such
/// as how long the processing job has been running. After the condition is met,
/// the processing job is stopped.
pub const ProcessingStoppingCondition = struct {
    /// Specifies the maximum runtime in seconds.
    max_runtime_in_seconds: i32,

    pub const json_field_names = .{
        .max_runtime_in_seconds = "MaxRuntimeInSeconds",
    };
};
