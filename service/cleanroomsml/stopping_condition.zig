/// The criteria used to stop model training.
pub const StoppingCondition = struct {
    /// The maximum amount of time, in seconds, that model training can run before
    /// it is terminated.
    max_runtime_in_seconds: i32 = 86400,

    pub const json_field_names = .{
        .max_runtime_in_seconds = "maxRuntimeInSeconds",
    };
};
