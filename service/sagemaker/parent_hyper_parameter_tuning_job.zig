/// A previously completed or stopped hyperparameter tuning job to be used as a
/// starting point for a new hyperparameter tuning job.
pub const ParentHyperParameterTuningJob = struct {
    /// The name of the hyperparameter tuning job to be used as a starting point for
    /// a new hyperparameter tuning job.
    hyper_parameter_tuning_job_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .hyper_parameter_tuning_job_name = "HyperParameterTuningJobName",
    };
};
