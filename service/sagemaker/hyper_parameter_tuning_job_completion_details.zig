/// A structure that contains runtime information about both current and
/// completed hyperparameter tuning jobs.
pub const HyperParameterTuningJobCompletionDetails = struct {
    /// The time in timestamp format that AMT detected model convergence, as defined
    /// by a lack of significant improvement over time based on criteria developed
    /// over a wide range of diverse benchmarking tests.
    convergence_detected_time: ?i64,

    /// The number of training jobs launched by a tuning job that are not improving
    /// (1% or less) as measured by model performance evaluated against an objective
    /// function.
    number_of_training_jobs_objective_not_improving: ?i32,

    pub const json_field_names = .{
        .convergence_detected_time = "ConvergenceDetectedTime",
        .number_of_training_jobs_objective_not_improving = "NumberOfTrainingJobsObjectiveNotImproving",
    };
};
