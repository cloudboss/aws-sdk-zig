/// Specifies limits for how long an Amazon Braket hybrid job can run.
pub const JobStoppingCondition = struct {
    /// The maximum length of time, in seconds, that an Amazon Braket hybrid job can
    /// run.
    max_runtime_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .max_runtime_in_seconds = "maxRuntimeInSeconds",
    };
};
