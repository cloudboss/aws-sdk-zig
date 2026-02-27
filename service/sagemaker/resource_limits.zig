/// Specifies the maximum number of training jobs and parallel training jobs
/// that a hyperparameter tuning job can launch.
pub const ResourceLimits = struct {
    /// The maximum number of training jobs that a hyperparameter tuning job can
    /// launch.
    max_number_of_training_jobs: ?i32,

    /// The maximum number of concurrent training jobs that a hyperparameter tuning
    /// job can launch.
    max_parallel_training_jobs: i32,

    /// The maximum time in seconds that a hyperparameter tuning job can run.
    max_runtime_in_seconds: ?i32,

    pub const json_field_names = .{
        .max_number_of_training_jobs = "MaxNumberOfTrainingJobs",
        .max_parallel_training_jobs = "MaxParallelTrainingJobs",
        .max_runtime_in_seconds = "MaxRuntimeInSeconds",
    };
};
