/// Describes the resource configuration for hyperparameter optimization (HPO).
pub const HPOResourceConfig = struct {
    /// The maximum number of training
    /// jobs when you create a
    /// solution
    /// version.
    /// The maximum value for `maxNumberOfTrainingJobs` is
    /// `40`.
    max_number_of_training_jobs: ?[]const u8,

    /// The maximum number of parallel training
    /// jobs when you create a
    /// solution
    /// version.
    /// The maximum value for `maxParallelTrainingJobs` is
    /// `10`.
    max_parallel_training_jobs: ?[]const u8,

    pub const json_field_names = .{
        .max_number_of_training_jobs = "maxNumberOfTrainingJobs",
        .max_parallel_training_jobs = "maxParallelTrainingJobs",
    };
};
