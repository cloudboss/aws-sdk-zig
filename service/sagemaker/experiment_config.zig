/// Associates a SageMaker job as a trial component with an experiment and
/// trial. Specified when you call the following APIs:
///
/// *
///   [CreateProcessingJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateProcessingJob.html)
/// *
///   [CreateTrainingJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingJob.html)
/// *
///   [CreateTransformJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTransformJob.html)
pub const ExperimentConfig = struct {
    /// The name of an existing experiment to associate with the trial component.
    experiment_name: ?[]const u8,

    /// The name of the experiment run to associate with the trial component.
    run_name: ?[]const u8,

    /// The display name for the trial component. If this key isn't specified, the
    /// display name is the trial component name.
    trial_component_display_name: ?[]const u8,

    /// The name of an existing trial to associate the trial component with. If not
    /// specified, a new trial is created.
    trial_name: ?[]const u8,

    pub const json_field_names = .{
        .experiment_name = "ExperimentName",
        .run_name = "RunName",
        .trial_component_display_name = "TrialComponentDisplayName",
        .trial_name = "TrialName",
    };
};
