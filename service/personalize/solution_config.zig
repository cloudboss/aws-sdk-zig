const aws = @import("aws");

const AutoMLConfig = @import("auto_ml_config.zig").AutoMLConfig;
const AutoTrainingConfig = @import("auto_training_config.zig").AutoTrainingConfig;
const EventsConfig = @import("events_config.zig").EventsConfig;
const HPOConfig = @import("hpo_config.zig").HPOConfig;
const OptimizationObjective = @import("optimization_objective.zig").OptimizationObjective;
const TrainingDataConfig = @import("training_data_config.zig").TrainingDataConfig;

/// Describes the configuration properties for the solution.
pub const SolutionConfig = struct {
    /// Lists the algorithm hyperparameters and their values.
    algorithm_hyper_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The
    /// [AutoMLConfig](https://docs.aws.amazon.com/personalize/latest/dg/API_AutoMLConfig.html) object containing a list of recipes to search
    /// when AutoML is performed.
    auto_ml_config: ?AutoMLConfig = null,

    /// Specifies the automatic training configuration to use.
    auto_training_config: ?AutoTrainingConfig = null,

    /// Describes the configuration of an event, which includes a list of event
    /// parameters. You can specify up to 10 event parameters. Events are used in
    /// solution creation.
    events_config: ?EventsConfig = null,

    /// Only events with a value greater than or equal to this threshold are
    /// used for training a model.
    event_value_threshold: ?[]const u8 = null,

    /// Lists the feature transformation parameters.
    feature_transformation_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Describes the properties for hyperparameter optimization (HPO).
    hpo_config: ?HPOConfig = null,

    /// Describes the additional objective for the solution, such as maximizing
    /// streaming
    /// minutes or increasing revenue. For more information see [Optimizing a
    /// solution](https://docs.aws.amazon.com/personalize/latest/dg/optimizing-solution-for-objective.html).
    optimization_objective: ?OptimizationObjective = null,

    /// Specifies the training data configuration to use when creating a custom
    /// solution version (trained model).
    training_data_config: ?TrainingDataConfig = null,

    pub const json_field_names = .{
        .algorithm_hyper_parameters = "algorithmHyperParameters",
        .auto_ml_config = "autoMLConfig",
        .auto_training_config = "autoTrainingConfig",
        .events_config = "eventsConfig",
        .event_value_threshold = "eventValueThreshold",
        .feature_transformation_parameters = "featureTransformationParameters",
        .hpo_config = "hpoConfig",
        .optimization_objective = "optimizationObjective",
        .training_data_config = "trainingDataConfig",
    };
};
