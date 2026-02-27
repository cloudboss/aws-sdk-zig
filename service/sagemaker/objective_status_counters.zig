/// Specifies the number of training jobs that this hyperparameter tuning job
/// launched, categorized by the status of their objective metric. The objective
/// metric status shows whether the final objective metric for the training job
/// has been evaluated by the tuning job and used in the hyperparameter tuning
/// process.
pub const ObjectiveStatusCounters = struct {
    /// The number of training jobs whose final objective metric was not evaluated
    /// and used in the hyperparameter tuning process. This typically occurs when
    /// the training job failed or did not emit an objective metric.
    failed: ?i32,

    /// The number of training jobs that are in progress and pending evaluation of
    /// their final objective metric.
    pending: ?i32,

    /// The number of training jobs whose final objective metric was evaluated by
    /// the hyperparameter tuning job and used in the hyperparameter tuning process.
    succeeded: ?i32,

    pub const json_field_names = .{
        .failed = "Failed",
        .pending = "Pending",
        .succeeded = "Succeeded",
    };
};
