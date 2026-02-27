/// A structure that keeps track of which training jobs launched by your
/// hyperparameter tuning job are not improving model performance as evaluated
/// against an objective function.
pub const BestObjectiveNotImproving = struct {
    /// The number of training jobs that have failed to improve model performance by
    /// 1% or greater over prior training jobs as evaluated against an objective
    /// function.
    max_number_of_training_jobs_not_improving: ?i32,

    pub const json_field_names = .{
        .max_number_of_training_jobs_not_improving = "MaxNumberOfTrainingJobsNotImproving",
    };
};
