const aws = @import("aws");

const AlgorithmImage = @import("algorithm_image.zig").AlgorithmImage;
const DefaultHyperParameterRanges = @import("default_hyper_parameter_ranges.zig").DefaultHyperParameterRanges;

/// Describes a custom algorithm.
pub const Algorithm = struct {
    /// The Amazon Resource Name (ARN) of the algorithm.
    algorithm_arn: ?[]const u8,

    /// The URI of the Docker container for the algorithm image.
    algorithm_image: ?AlgorithmImage,

    /// The date and time (in Unix time) that the algorithm was created.
    creation_date_time: ?i64,

    /// Specifies the default hyperparameters, their ranges, and whether they
    /// are tunable. A tunable hyperparameter can
    /// have its value determined during hyperparameter optimization (HPO).
    default_hyper_parameter_ranges: ?DefaultHyperParameterRanges,

    /// Specifies the default hyperparameters.
    default_hyper_parameters: ?[]const aws.map.StringMapEntry,

    /// Specifies the default maximum number of training jobs and parallel training
    /// jobs.
    default_resource_config: ?[]const aws.map.StringMapEntry,

    /// The date and time (in Unix time) that the algorithm was last updated.
    last_updated_date_time: ?i64,

    /// The name of the algorithm.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the role.
    role_arn: ?[]const u8,

    /// The training input mode.
    training_input_mode: ?[]const u8,

    pub const json_field_names = .{
        .algorithm_arn = "algorithmArn",
        .algorithm_image = "algorithmImage",
        .creation_date_time = "creationDateTime",
        .default_hyper_parameter_ranges = "defaultHyperParameterRanges",
        .default_hyper_parameters = "defaultHyperParameters",
        .default_resource_config = "defaultResourceConfig",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .role_arn = "roleArn",
        .training_input_mode = "trainingInputMode",
    };
};
