/// The serverless training job progress information.
pub const TrainingProgressInfo = struct {
    /// The current epoch number.
    current_epoch: ?i64,

    /// The current step number.
    current_step: ?i64,

    /// The maximum number of epochs for this job.
    max_epoch: ?i64,

    /// The total step count per epoch.
    total_step_count_per_epoch: ?i64,

    pub const json_field_names = .{
        .current_epoch = "CurrentEpoch",
        .current_step = "CurrentStep",
        .max_epoch = "MaxEpoch",
        .total_step_count_per_epoch = "TotalStepCountPerEpoch",
    };
};
