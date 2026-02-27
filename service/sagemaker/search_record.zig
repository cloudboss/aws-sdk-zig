const Endpoint = @import("endpoint.zig").Endpoint;
const Experiment = @import("experiment.zig").Experiment;
const FeatureGroup = @import("feature_group.zig").FeatureGroup;
const FeatureMetadata = @import("feature_metadata.zig").FeatureMetadata;
const HyperParameterTuningJobSearchEntity = @import("hyper_parameter_tuning_job_search_entity.zig").HyperParameterTuningJobSearchEntity;
const ModelDashboardModel = @import("model_dashboard_model.zig").ModelDashboardModel;
const ModelCard = @import("model_card.zig").ModelCard;
const ModelPackage = @import("model_package.zig").ModelPackage;
const ModelPackageGroup = @import("model_package_group.zig").ModelPackageGroup;
const Pipeline = @import("pipeline.zig").Pipeline;
const PipelineExecution = @import("pipeline_execution.zig").PipelineExecution;
const PipelineVersion = @import("pipeline_version.zig").PipelineVersion;
const Project = @import("project.zig").Project;
const TrainingJob = @import("training_job.zig").TrainingJob;
const Trial = @import("trial.zig").Trial;
const TrialComponent = @import("trial_component.zig").TrialComponent;

/// A single resource returned as part of the
/// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API response.
pub const SearchRecord = struct {
    endpoint: ?Endpoint,

    /// The properties of an experiment.
    experiment: ?Experiment,

    feature_group: ?FeatureGroup,

    /// The feature metadata used to search through the features.
    feature_metadata: ?FeatureMetadata,

    /// The properties of a hyperparameter tuning job.
    hyper_parameter_tuning_job: ?HyperParameterTuningJobSearchEntity,

    model: ?ModelDashboardModel,

    /// An Amazon SageMaker Model Card that documents details about a machine
    /// learning model.
    model_card: ?ModelCard,

    model_package: ?ModelPackage,

    model_package_group: ?ModelPackageGroup,

    pipeline: ?Pipeline,

    pipeline_execution: ?PipelineExecution,

    /// The version of the pipeline.
    pipeline_version: ?PipelineVersion,

    /// The properties of a project.
    project: ?Project,

    /// The properties of a training job.
    training_job: ?TrainingJob,

    /// The properties of a trial.
    trial: ?Trial,

    /// The properties of a trial component.
    trial_component: ?TrialComponent,

    pub const json_field_names = .{
        .endpoint = "Endpoint",
        .experiment = "Experiment",
        .feature_group = "FeatureGroup",
        .feature_metadata = "FeatureMetadata",
        .hyper_parameter_tuning_job = "HyperParameterTuningJob",
        .model = "Model",
        .model_card = "ModelCard",
        .model_package = "ModelPackage",
        .model_package_group = "ModelPackageGroup",
        .pipeline = "Pipeline",
        .pipeline_execution = "PipelineExecution",
        .pipeline_version = "PipelineVersion",
        .project = "Project",
        .training_job = "TrainingJob",
        .trial = "Trial",
        .trial_component = "TrialComponent",
    };
};
