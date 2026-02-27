/// The trial that a trial component is associated with and the experiment the
/// trial is part of. A component might not be associated with a trial. A
/// component can be associated with multiple trials.
pub const Parent = struct {
    /// The name of the experiment.
    experiment_name: ?[]const u8,

    /// The name of the trial.
    trial_name: ?[]const u8,

    pub const json_field_names = .{
        .experiment_name = "ExperimentName",
        .trial_name = "TrialName",
    };
};
