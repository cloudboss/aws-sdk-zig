/// Specifies the names of the experiment and trial created by a pipeline.
pub const PipelineExperimentConfig = struct {
    /// The name of the experiment.
    experiment_name: ?[]const u8,

    /// The name of the trial.
    trial_name: ?[]const u8,

    pub const json_field_names = .{
        .experiment_name = "ExperimentName",
        .trial_name = "TrialName",
    };
};
