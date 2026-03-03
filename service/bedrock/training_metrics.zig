/// Metrics associated with the custom job.
pub const TrainingMetrics = struct {
    /// Loss metric associated with the custom job.
    training_loss: ?f32 = null,

    pub const json_field_names = .{
        .training_loss = "trainingLoss",
    };
};
