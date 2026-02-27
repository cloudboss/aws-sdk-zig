const aws = @import("aws");

const Channel = @import("channel.zig").Channel;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const ResourceConfig = @import("resource_config.zig").ResourceConfig;
const StoppingCondition = @import("stopping_condition.zig").StoppingCondition;
const TrainingInputMode = @import("training_input_mode.zig").TrainingInputMode;

/// Defines the input needed to run a training job using the algorithm.
pub const TrainingJobDefinition = struct {
    /// The hyperparameters used for the training job.
    hyper_parameters: ?[]const aws.map.StringMapEntry,

    /// An array of `Channel` objects, each of which specifies an input source.
    input_data_config: []const Channel,

    /// the path to the S3 bucket where you want to store model artifacts. SageMaker
    /// creates subfolders for the artifacts.
    output_data_config: OutputDataConfig,

    /// The resources, including the ML compute instances and ML storage volumes, to
    /// use for model training.
    resource_config: ResourceConfig,

    /// Specifies a limit to how long a model training job can run. It also
    /// specifies how long a managed Spot training job has to complete. When the job
    /// reaches the time limit, SageMaker ends the training job. Use this API to cap
    /// model training costs.
    ///
    /// To stop a job, SageMaker sends the algorithm the SIGTERM signal, which
    /// delays job termination for 120 seconds. Algorithms can use this 120-second
    /// window to save the model artifacts.
    stopping_condition: StoppingCondition,

    training_input_mode: TrainingInputMode,

    pub const json_field_names = .{
        .hyper_parameters = "HyperParameters",
        .input_data_config = "InputDataConfig",
        .output_data_config = "OutputDataConfig",
        .resource_config = "ResourceConfig",
        .stopping_condition = "StoppingCondition",
        .training_input_mode = "TrainingInputMode",
    };
};
